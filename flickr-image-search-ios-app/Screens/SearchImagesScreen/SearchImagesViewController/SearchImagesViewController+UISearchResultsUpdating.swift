//
//  SearchImagesViewController+UISearchResultsUpdating.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - SearchImagesViewController+UISearchResultsUpdating

extension SearchImagesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        /*guard let text = searchController.searchBar.text else { return }
        print(text)*/
    }
}

// MARK: - SearchImagesViewController+UISearchBarDelegate

extension SearchImagesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.viewModel?.searchImagesByText(searchText)
    }
}
