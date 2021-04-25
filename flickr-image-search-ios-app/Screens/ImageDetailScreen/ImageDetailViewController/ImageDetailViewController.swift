//
//  ImageDetailViewController.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - ImageDetailViewController

final class ImageDetailViewController: UIViewController {
    
    // MARK: - LocalizedText
    
    enum LocalizedText {
        static let infoSectionHeaderText = NSLocalizedString("Information", comment: .empty)
    }
    
    // MARK: - UI Elements
    
    // TODO: add states (empty, loading, filled with content or empty)
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
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
        viewModel?.loadExifInformation()
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
    
    // MARK: - Setup (Delegate)Binding between view controller and view model
    
    private func setupViewModelBinding() {
        self.viewModel?.delegate = self
    }
}

// MARK: - ImageDetailViewController+IImageDetailViewModelDelegate

extension ImageDetailViewController: IImageDetailViewModelDelegate {
    
    func exifInformationDidLoad() {
        
    }
}
