//
//  MainCoordinator.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - MainCoordinator

final class MainCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FlickrSearchImageViewModel()
        let searchImagesViewController = SearchImagesViewController(viewModel: viewModel)
        searchImagesViewController.coordinator = self
        navigationController.pushViewController(searchImagesViewController, animated: false)
    }
}

// MARK: - MainCoordinator+ISearchImagesCoordinator

extension MainCoordinator: ISearchImagesCoordinator {
    
    func selectPhoto(flickrPhoto: FlickrPhoto) {
        let viewModel = FlickrImageDetailViewModel(image: flickrPhoto)
        let imageDetailViewController = ImageDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }
}
