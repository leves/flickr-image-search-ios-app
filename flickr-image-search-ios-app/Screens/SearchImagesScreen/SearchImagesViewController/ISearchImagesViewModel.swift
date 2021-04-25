//
//  ISearchImagesViewModel.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - ISearchImagesViewModel

protocol ISearchImagesViewModel: class {
    
    var searchTerm: String { get set }
    
    var images: [ImageURLProvider] { get }
    var hasMoreImageToFetch: Bool { get }
    
    var delegate: ISearchImagesViewModelDelegate? { get set }
    
    func searchImagesByText(_ text: String)
    func loadMoreImages()
    func configure(cell: ImageItemCollectionViewCell, withData data: ImageURLProvider)
}

// MARK: - ImageURLProvider

protocol ImageURLProvider {
    
    var thumbnailImageURL: URL { get }
    var largeImageURL: URL { get }
}

// MARK: - ISearchImagesViewModelDelegate

protocol ISearchImagesViewModelDelegate: class {
    
    func imagesDidLoad()
    func imagesDidUpdate(at range: Range<Int>)
}
