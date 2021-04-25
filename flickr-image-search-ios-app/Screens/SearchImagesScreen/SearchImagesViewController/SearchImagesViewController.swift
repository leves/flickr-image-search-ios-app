//
//  SearchImagesViewController.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - SearchImagesViewController

final class SearchImagesViewController: UIViewController {
    
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
    
    // MARK: - Setup (Delegate)Binding between view controller and view model
    
    private func setupViewModelBinding() {
        self.viewModel?.delegate = self
    }
}

// MARK: - SearchImagesViewController+ISearchImagesViewModelDelegate

extension SearchImagesViewController: ISearchImagesViewModelDelegate {
    
    func imagesDidLoad() {
        
    }
    
    func imagesDidUpdate(at range: Range<Int>) {
        
    }
}
