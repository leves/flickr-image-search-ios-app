//
//  ImageDetailViewController+UITableViewDataSource.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - ImageDetailViewController+UITableViewDataSource

extension ImageDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.exifs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier, for: indexPath)
    
        if let informationCell = cell as? InformationTableViewCell,
           let exif = viewModel?.exifs[indexPath.row] {
            viewModel?.configure(cell: informationCell, withData: exif)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LocalizedText.infoSectionHeaderText
    }
}
