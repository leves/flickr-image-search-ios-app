//
//  ImageDetailViewController.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit
import Kingfisher

// MARK: - ImageDetailViewController

final class ImageDetailViewController: UIViewController {
    
    // MARK: - LocalizedText
    
    enum LocalizedText {
        static let infoSectionHeaderText = NSLocalizedString("Information", comment: .empty)
    }
    
    // MARK: - Statics
    
    static let headerHeight: CGFloat = 250
    
    // MARK: - UI Elements
    
    // TODO: add states (empty, loading, filled with content or empty)
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InformationTableViewCell.self, forCellReuseIdentifier: InformationTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let headerImageView = InteractiveImageViewWithGuide()
    
    // MARK: - Properties
    
    var viewModel: IImageDetailViewModel? {
        didSet {
            setupViewModelBinding()
        }
    }
    
    // MARK: - Init(s)
    
    convenience init(viewModel: IImageDetailViewModel) {
        self.init()
        self.viewModel = viewModel
        setupViewModelBinding()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.titleText
        buildViewHierarchy()
        setupTableViewHeader()
        
        headerImageView.imageView.kf.setImage(with: viewModel?.imageURL) { [weak self] (_) in
            self?.headerImageView.updateZoomScale()
        } // TODO: add placeholder image and/or loading indicator
        
        viewModel?.loadExifInformation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerImageView.startGuidingAnimation()
    }
    
    // MARK: - Build View Hierarchy
    
    private func buildViewHierarchy() {
        
        // MARK: Table View
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Setup Table View Header
    
    private func setupTableViewHeader() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Self.headerHeight))
        containerView.addSubview(headerImageView)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        headerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        tableView.tableHeaderView = containerView
    }
    
    // MARK: - Setup (Delegate)Binding between view controller and view model
    
    private func setupViewModelBinding() {
        self.viewModel?.delegate = self
    }
}

// MARK: - ImageDetailViewController+IImageDetailViewModelDelegate

extension ImageDetailViewController: IImageDetailViewModelDelegate {
    
    func exifInformationDidLoad() {
        self.tableView.reloadData()
    }
}
