//
//  FlickrSearchImageViewModel.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - FlickrSearchImageViewModel

final class FlickrSearchImageViewModel: ISearchImagesViewModel {
    
    var searchTerm = ""
    
    private(set) var images: [ImageURLProvider]
    private(set) var hasMoreImageToFetch = false
    
    weak var delegate: ISearchImagesViewModelDelegate?
    
    // MARK: - Init(s)
    
    init() {
        images = [FlickrPhoto]()
    }
    
    // MARK: - Intent(s)
    
    func searchImagesByText(_ text: String) {
        
    }
    
    func loadMoreImages() {
        
    }
    
    func flickrPhoto(for imageURLProvider: ImageURLProvider) -> FlickrPhoto? {
        return nil
    }
    
    func configure(cell: ImageItemCollectionViewCell, withData data: ImageURLProvider) {
        
    }
}
