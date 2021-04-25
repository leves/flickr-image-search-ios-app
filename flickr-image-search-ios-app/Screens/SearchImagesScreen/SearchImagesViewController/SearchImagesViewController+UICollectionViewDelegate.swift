//
//  SearchImagesViewController+UICollectionViewDelegate.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - SearchImagesViewController+UICollectionViewDelegate

extension SearchImagesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard cell is ImageItemCollectionViewCell else { return }
        guard let selectedImage = viewModel?.images[indexPath.row] else { return }
        self.coordinator?.selectPhoto() // TODO: pass the photo
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let loadingItem = cell as? LoadingCollectionViewCell else { return }
        loadingItem.activityIndicatorView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel?.loadMoreImages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let loadingItem = cell as? LoadingCollectionViewCell else { return }
        loadingItem.activityIndicatorView.stopAnimating()
    }
}
