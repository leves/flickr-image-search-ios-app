//
//  Helpers.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import Foundation

// MARK: - String extension

extension String {
    
    static var empty: String { "" }
}

// MARK: - UserDefault Property Wrapper

@propertyWrapper
struct UserDefault<Value> {
    
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        
        set {
            container.set(newValue, forKey: key)
            container.synchronize()
        }
    }
}
