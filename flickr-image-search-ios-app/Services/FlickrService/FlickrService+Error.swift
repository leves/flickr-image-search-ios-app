//
//  FlickrService+Error.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import Foundation

// MARK: - FlickrService+Error

enum FlickrServiceError: Error {
    
    case dataTaskIssue(error: Error)
    case missingData
    case cantParseJSON(json: String)
}

// MARK: - LocalizedError

extension FlickrServiceError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .dataTaskIssue(let error):
            return error.localizedDescription
        case .missingData:
            return "No data in response..."
        case .cantParseJSON(let json):
            return "Can't parse JSON: \(json)"
        }
    }
}
