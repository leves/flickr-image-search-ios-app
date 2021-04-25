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
        
        viewModel?.loadExifInformation()
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
