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
        static let searchPlaceholder = NSLocalizedString("Search for Images", comment: "")
    }
    
    // MARK: - UI Elements
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = LocalizedText.searchPlaceholder
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    // MARK: - Properties
    
    weak var coordinator: ISearchImagesCoordinator?
    var viewModel: ISearchImagesViewModel? {
        didSet {
            setupViewModelBinding()
        }
    }
    
    // MARK: - Init(s)
    
    convenience init(viewModel: ISearchImagesViewModel) {
        self.init()
        self.viewModel = viewModel
        setupViewModelBinding()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        resumeWithPreviousSearch()
    }
    
    // MARK: - Setup Search
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchBar.text = viewModel?.searchTerm ?? ""
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
}

// MARK: - SearchImagesViewController+ISearchImagesViewModelDelegate

extension SearchImagesViewController: ISearchImagesViewModelDelegate {
    
    func imagesDidLoad() {
        
    }
    
    func imagesDidUpdate(at range: Range<Int>) {
        
    }
}
