//
//  ImageItemCollectionViewCell.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - ImageItemCollectionViewCell

final class ImageItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Statics
    
    static let reuseIdentifier = String(describing: ImageItemCollectionViewCell.self)
    static let imageViewCornerRadius: CGFloat = 10
    
    // MARK: - UI Elements
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemFill
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ImageItemCollectionViewCell.imageViewCornerRadius
        return imageView
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
        
        // MARK: Image View
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
    }
}
