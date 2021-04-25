//
//  InformationTableViewCell.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - InformationTableViewCell

final class InformationTableViewCell: UITableViewCell {
    
    // MARK: - Statics
    
    static let reuseIdentifier = String(describing: InformationTableViewCell.self)
    
    // MARK: - Init(s)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
