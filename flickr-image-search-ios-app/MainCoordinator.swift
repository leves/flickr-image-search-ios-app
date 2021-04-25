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
        let searchImagesViewController = UIViewController()
        searchImagesViewController.view.backgroundColor = .red
        navigationController.pushViewController(searchImagesViewController, animated: false)
    }
}
