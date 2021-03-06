//
//  SearchImagesViewController.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - SearchImagesViewController

final class SearchImagesViewController: UIViewController {
    
    // MARK: - LocalizedText
    
    enum LocalizedText {
        static let titleText = NSLocalizedString("Image Search", comment: .empty)
        static let searchPlaceholder = NSLocalizedString("Search for Images", comment: .empty)
    }
    
    // MARK: - Statics
    
    static let defaultSpacingForCollectionView: CGFloat = 10
    static let defaultAspectRatioForCollectionViewItem: CGFloat = 3/4 // 4:3 -> 3/4, 16:9 -> 9/16
    
    // MARK: - UI Elements
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = LocalizedText.searchPlaceholder
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    // TODO: add states (empty, loading, filled with content or empty)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: ImageItemCollectionViewCell.reuseIdentifier)
        collectionView.register(LoadingCollectionViewCell.self,
                                forCellWithReuseIdentifier: LoadingCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .always
        return collectionView
    }()
    
    // MARK: - Properties
    
    weak var coordinator: ISearchImagesCoordinator?
    var viewModel: ISearchImagesViewModel? {
        didSet {
            setupViewModelBinding()
        }
    }
    
    private var collectionViewLoadingItemIndexPath: IndexPath?
    
    // MARK: - Init(s)
    
    convenience init(viewModel: ISearchImagesViewModel) {
        self.init()
        self.viewModel = viewModel
        setupViewModelBinding()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizedText.titleText
        buildViewHierarchy()
        setupSearchController()
        resumeWithPreviousSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Build View Hierarchy
    
    private func buildViewHierarchy() {
        
        // MARK: Collection View
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Setup Search
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchBar.text = viewModel?.searchTerm ?? .empty
    }
    
    // MARK: - Setup (Delegate)Binding between view controller and view model
    
    private func setupViewModelBinding() {
        self.viewModel?.delegate = self
    }
    
    // MARK: - Resume With Previous Search
    
    private func resumeWithPreviousSearch() {
        guard let previousSearchTerm = self.viewModel?.searchTerm else { return }
        self.viewModel?.searchImagesByText(previousSearchTerm)
    }
    
    // MARK: - Handle Keyboard
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func handleKeyboardWillShowNotification(notification: Notification) {
        guard let keyboardInfo = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrameEndFrame = keyboardInfo.cgRectValue
        let bottomInset = keyboardFrameEndFrame.height - self.view.safeAreaInsets.bottom
        collectionView.contentInset.bottom = bottomInset
        collectionView.verticalScrollIndicatorInsets.bottom = bottomInset
    }
    
    @objc
    private func handleKeyboardWillHideNotification() {
        let bottomInset: CGFloat = 0
        collectionView.contentInset.bottom = bottomInset
        collectionView.verticalScrollIndicatorInsets.bottom = bottomInset
    }
}

// MARK: - SearchImagesViewController+ISearchImagesViewModelDelegate

extension SearchImagesViewController: ISearchImagesViewModelDelegate {
    
    func imagesDidLoad() {
        self.collectionView.reloadData()
        if self.collectionView.contentOffset.y > 0 {
            self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
        }
    }
    
    func imagesDidUpdate(at range: Range<Int>) {
        let locations = range.map{ IndexPath(row: $0, section: 0) }
        //print(locations)
        
        self.collectionView.performBatchUpdates({
            
            // Remove loading item before update (if needed)
            if let loadingItemIndexPath = self.collectionViewLoadingItemIndexPath {
                self.collectionView.deleteItems(at: [loadingItemIndexPath])
            }
            
            // Add fetched items to the list
            self.collectionView.insertItems(at: locations)
            
            // Add loading item to the end of the list (if needed)
            if let viewModel = viewModel, viewModel.hasMoreImageToFetch == true {
                self.collectionView.insertItems(at: [IndexPath(item: viewModel.images.count, section: 0)])
            }
        }, completion: nil)
    }
}

// MARK: - SearchImagesViewController+UICollectionViewDataSource

extension SearchImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        let searchItemIfNeeded = viewModel.hasMoreImageToFetch ? 1 : 0
        return viewModel.images.count + searchItemIfNeeded
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier: String
        
        if viewModel!.images.indices.contains(indexPath.row) {
            reuseIdentifier = ImageItemCollectionViewCell.reuseIdentifier
        }else{
            reuseIdentifier = LoadingCollectionViewCell.reuseIdentifier
            collectionViewLoadingItemIndexPath = indexPath
        }
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)
        
        if let imageItem = item as? ImageItemCollectionViewCell,
           let data = viewModel?.images[indexPath.row] {
            viewModel?.configure(cell: imageItem, withData: data)
        }
        
        return item
    }
}
