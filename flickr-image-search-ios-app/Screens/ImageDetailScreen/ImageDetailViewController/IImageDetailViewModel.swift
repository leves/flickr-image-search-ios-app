//
//  IImageDetailViewModel.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - IImageDetailViewModel

protocol IImageDetailViewModel: class {
    
    var exifs: [(label: String, value: String)] { get }
    
    var titleText: String { get }
    var imageURL: URL { get }
    
    var delegate: IImageDetailViewModelDelegate? { get set }
    
    func loadExifInformation()
}

// MARK: - ISearchImagesViewModelDelegate

protocol IImageDetailViewModelDelegate: class {
    
    func exifInformationDidLoad()
}
