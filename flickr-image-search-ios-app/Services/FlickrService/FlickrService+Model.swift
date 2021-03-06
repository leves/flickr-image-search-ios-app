//
//  FlickrService+Model.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import Foundation

// MARK: - FlickrService+Model Generated by: LBTools

extension FlickrService {
    
    enum PhotoSize: String {
        case thumbnail75    = "s"   //cropped square
        case thumbnail150   = "q"   //cropped square
        case thumbnail100   = "t"
        case small240       = "m"
        case small320       = "n"
        case small400       = "w"
        case medium640      = "z"
        case medium800      = "c"
        case large1024      = "b"
        case large1600      = "h"   // has a unique secret; photo owner can restrict
        case large2048      = "k"   // has a unique secret; photo owner can restrict
        case extraLarge3072 = "3k"  // has a unique secret; photo owner can restrict
        case extraLarge4096 = "4k"  // has a unique secret; photo owner can restrict
        case extraLarge5120 = "5k"  // has a unique secret; photo owner can restrict
        case extraLarge6144 = "6k"  // has a unique secret; photo owner can restrict
        case original       = "o"   // has a unique secret; photo owner can restrict; files have full EXIF data; files might not be rotated; files can use an arbitrary file extension
    }
    
    struct PhotoSearchResult: Decodable {
        let photos: Photos
        let stat: String
    }

    struct Photos: Decodable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: String
        let photo: [Photo]
    }

    struct Photo: Decodable {
        let id: String
        let owner: String
        let secret: String
        let server: String
        let farm: Int
        let title: String
        let ispublic: Int
        let isfriend: Int
        let isfamily: Int
    }
    
    struct PhotoInfoSearchResult: Decodable {
        let photo: PhotoInfo
        let stat: String
    }
    
    struct PhotoInfo: Decodable {
        let id: String
        let secret: String
        let server: String
        let farm: Int
        let camera: String
        let exif: [Exif]
    }
    
    struct Exif: Decodable {
        let tagspace: String
        let tagspaceid: Int
        let tag: String
        let label: String
        let raw: Value
        let clean: Value?
    }
    
    struct Value: Decodable {
        let _content: String
    }
}
