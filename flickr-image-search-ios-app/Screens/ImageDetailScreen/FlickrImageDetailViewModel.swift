//
//  FlickrImageDetailViewModel.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - FlickrImageDetailViewModel

final class FlickrImageDetailViewModel: IImageDetailViewModel {
    
    var exifs = [(label: String, value: String)]()
    
    var titleText: String {
        image.wrappedValue.title
    }
    
    var imageURL: URL {
        image.largeImageURL
    }
    weak var delegate: IImageDetailViewModelDelegate?
    
    let image: FlickrPhoto
    
    // MARK: - Init(s)
    
    init(image: FlickrPhoto) {
        self.image = image
    }
    
    // MARK: - Intent(s)
    
    func loadExifInformation() {
        
    }
    
    func configure(cell: InformationTableViewCell, withData data: (label: String, value: String)) {
        
    }
}
