//
//  SearchImagesViewController+UICollectionViewDelegateFlowLayout.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 25..
//

import UIKit

// MARK: - SearchImagesViewController+UICollectionViewDelegateFlowLayout

extension SearchImagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize: CGSize
        
        if self.viewModel!.images.indices.contains(indexPath.row) {
            let horizontalSizeClass = self.traitCollection.horizontalSizeClass
            if  horizontalSizeClass == .compact {
                itemSize = itemSizeForItemCountInRow(2)
            }else {
                itemSize = itemSizeForItemCountInRow(4)
            }
        }else{
            itemSize = CGSize(width: availableContainerWidth, height: LoadingCollectionViewCell.preferredHeight)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Self.defaultSpacingForCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Self.defaultSpacingForCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = Self.defaultSpacingForCollectionView
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    // MARK: Helpers
    
    private var containerWidth: CGFloat {
        self.view.frame.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right
    }
    
    private var availableContainerWidth: CGFloat {
        let collectionViewHorizontalPadding = Self.defaultSpacingForCollectionView
        return containerWidth - collectionViewHorizontalPadding * 2
    }
    
    private func itemSizeForItemCountInRow(_ itemCountInRow: Int) -> CGSize {
        let _itemCountInRow = CGFloat(itemCountInRow)
        let itemPadding = Self.defaultSpacingForCollectionView
        let itemAspectRatio = Self.defaultAspectRatioForCollectionViewItem
        
        let availableWidth = availableContainerWidth - itemPadding * (_itemCountInRow - 1)
        let itemWidth = availableWidth / _itemCountInRow
        
        return CGSize(width: itemWidth, height: itemWidth * itemAspectRatio)
    }
}
