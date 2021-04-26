//
//  ISearchImagesCoordinator.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import Foundation

// MARK: - ISearchImagesCoordinator

protocol ISearchImagesCoordinator: class {
    
    func selectPhoto(flickrPhoto: FlickrPhoto)
}
