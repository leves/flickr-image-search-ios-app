//
//  FlickrService.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import Foundation

// MARK: - FlickrService

struct FlickrService { // TODO: Needs an interface for easier mocking!
    
    // MARK: - API URL & KEY
    
    private static let apiURL = URL(string: "https://www.flickr.com/services/rest/")!
    private static let apiKey = "YOUR_FLICKR_API_KEY_HERE"
    
    // MARK: - Photo Image URL For Photo
    // https://www.flickr.com/services/api/misc.urls.html
    
    func photoImageURL(for photo: Photo, inSize photoSize: PhotoSize = .medium640) -> URL {
        URL(string: "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_\(photoSize.rawValue).jpg")!
    }
    
    // MARK: - Perform Data Task With Query Items
    
    func performDataTaskWithQueryItems<T: Decodable>(_ queryItems: [URLQueryItem],
                                                     completion: @escaping (Result<T, FlickrServiceError>) -> Void,
                                                     cachePolicy:  URLRequest.CachePolicy = .returnCacheDataElseLoad,
                                                     timeoutInterval: TimeInterval = 30) {
        
        var api = URLComponents(url: Self.apiURL, resolvingAgainstBaseURL: false)!
        let apiKeyItem = URLQueryItem(name: "api_key", value: Self.apiKey)
        api.queryItems = queryItems + [apiKeyItem]
        //print("URL to perform: \(api.url!)")
        let request = URLRequest(url: api.url!,
                                 cachePolicy: cachePolicy,
                                 timeoutInterval: timeoutInterval)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("response: \(response)")
            guard error == nil else {
                completion(Result<T, FlickrServiceError>.failure(.dataTaskIssue(error: error!)))
                return
            }
            guard let data = data else {
                completion(Result<T, FlickrServiceError>.failure(.missingData))
                return
            }
            
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(T.self, from: data) else {
                let json = String(data: data, encoding: .utf8) ?? "JSON content is not available"
                completion(Result<T, FlickrServiceError>.failure(.cantParseJSON(json: json)))
                return
            }
            completion(Result<T, FlickrServiceError>.success(result))
        }.resume()
    }
}
