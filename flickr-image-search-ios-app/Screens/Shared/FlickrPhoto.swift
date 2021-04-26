//
//  FlickrPhoto.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import Foundation

// MARK: - FlickrPhoto

struct FlickrPhoto: ImageURLProvider {
    
    let thumbnailImageURL: URL
    let largeImageURL: URL
    
    let wrappedValue: FlickrService.Photo
}
