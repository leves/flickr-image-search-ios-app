//
//  LoadingCollectionViewCell.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - LoadingCollectionViewCell

final class LoadingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Statics
    
    static let reuseIdentifier = String(describing: LoadingCollectionViewCell.self)
    static let preferredHeight: CGFloat = 50
    
    // MARK: - UI Elements
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    // MARK: - Init(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Build View Hierarchy
    
    private func buildViewHierarchy() {
        
        // MARK: Activity Indicator View
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(activityIndicatorView)
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
    }
}
