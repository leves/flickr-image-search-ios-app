//
//  FlickrService+Endpoint.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import Foundation

// MARK: - FlickrService+Endpoint

extension FlickrService {
    
    /*
     API Docs:
     https://www.flickr.com/services/api/explore/flickr.photos.search
    
     Sample API Call:
     https://www.flickr.com/services/rest/?method=flickr.photos.search&text=dog&per_page=20&page=1&format=json&nojsoncallback=1&api_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    */
    
    func searchImagesByTitle(_ imageTitle: String, page: Int, perPage:Int,
                             completion: @escaping (Result<PhotoSearchResult, FlickrServiceError>) -> Void) {
        
        let validPage = max(1, page)
        let validPerPage = min(500, perPage)
        
        let methodQueryItem = URLQueryItem(name: "method", value: "flickr.photos.search")
        let textQueryItem = URLQueryItem(name: "text", value: imageTitle)
        let perPageQueryItem = URLQueryItem(name: "per_page", value: "\(validPerPage)")
        let pageQueryItem = URLQueryItem(name: "page", value: "\(validPage)")
        let formatQueryItem = URLQueryItem(name: "format", value: "json")
        let jsonCallbackQueryItem = URLQueryItem(name: "nojsoncallback", value: "1")
        let queryItems = [methodQueryItem, textQueryItem, perPageQueryItem, pageQueryItem, formatQueryItem, jsonCallbackQueryItem]
        self.performDataTaskWithQueryItems(queryItems, completion: completion)
    }
    
    /*
     API Docs:
     https://www.flickr.com/services/api/explore/flickr.photos.getExif
     
     Sample API Call:
     https://www.flickr.com/services/rest/?method=flickr.photos.getExif&api_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&photo_id=51131349327&secret=fb52b1ea2d&format=json&nojsoncallback=1
    */
    
    func getExif(for photo: Photo, completion: @escaping (Result<PhotoInfoSearchResult, FlickrServiceError>) -> Void) {
        let methodQueryItem = URLQueryItem(name: "method", value: "flickr.photos.getExif")
        let photoIdQueryItem = URLQueryItem(name: "photo_id", value: photo.id)
        let secretQueryItem = URLQueryItem(name: "secret", value: photo.secret)
        let formatQueryItem = URLQueryItem(name: "format", value: "json")
        let jsonCallbackQueryItem = URLQueryItem(name: "nojsoncallback", value: "1")
        let queryItems = [methodQueryItem, photoIdQueryItem, secretQueryItem, formatQueryItem, jsonCallbackQueryItem]
        self.performDataTaskWithQueryItems(queryItems, completion: completion)
    }
}
