//
//  FlickrSearchImageViewModel.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit
import Kingfisher

// MARK: - FlickrSearchImageViewModel

final class FlickrSearchImageViewModel: ISearchImagesViewModel {
    
    static let resultsPerPage = 20
    
    @UserDefault(key: "image-search-term", defaultValue: "dog")
    var searchTerm: String
    
    private(set) var images: [ImageURLProvider]
    private(set) var hasMoreImageToFetch = false
    
    weak var delegate: ISearchImagesViewModelDelegate?
    
    private let flickrService = FlickrService() // TODO: FlickrService is coupled with ViewModel -> decoupled it!!!
    private var currentPage = 1
    
    private lazy var loadMoreImagesOperationQueue: OperationQueue = { // protect against 'loadMoreImages()' spamming
        let operationQueue = OperationQueue()
        operationQueue.name = "load-more-images-queue"
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    // MARK: - Init(s)
    
    init() {
        images = [FlickrPhoto]()
    }
    
    // MARK: - Intent(s)
    
    func searchImagesByText(_ text: String) {
        searchTerm = text
        currentPage = 1
        _searchImagesByText(searchTerm, page: currentPage)
    }
    
    func loadMoreImages() {
        loadMoreImagesOperationQueue.addOperation { [weak self] in
            self?._loadMoreImages()
        }
    }
    
    func flickrPhoto(for imageURLProvider: ImageURLProvider) -> FlickrPhoto? {
        imageURLProvider as? FlickrPhoto
    }
    
    func configure(cell: ImageItemCollectionViewCell, withData data: ImageURLProvider) {
        cell.imageView.kf.setImage(with: data.thumbnailImageURL)
    }
    
    // MARK: -
    
    private func _loadMoreImages() {
        guard hasMoreImageToFetch else { return }
        currentPage += 1
        _searchImagesByText(searchTerm, page: currentPage)
        loadMoreImagesOperationQueue.cancelAllOperations()
    }
    
    private func _searchImagesByText(_ text: String, page: Int) {
        flickrService.searchImagesByTitle(text, page: page, perPage: Self.resultsPerPage) { [weak self] result in
            self?.handleSearchImagesByTextCallbackAtPage(page, result: result)
        }
    }
    
    private typealias ImageSearchResult = Result<FlickrService.PhotoSearchResult, FlickrServiceError>
    private func handleSearchImagesByTextCallbackAtPage(_ page: Int, result: ImageSearchResult) {
        
        switch result {
        case .success(let photoSearchResult):
            let flickrPhotos = photoSearchResult.photos.photo.map { photo -> FlickrPhoto in
                let thumbnailImageURL = flickrService.photoImageURL(for: photo)
                let largeImageURL = flickrService.photoImageURL(for: photo, inSize: .large1024)
                return FlickrPhoto(thumbnailImageURL: thumbnailImageURL, largeImageURL: largeImageURL, wrappedValue: photo)
            }
            
            let lastPage = Int(photoSearchResult.photos.pages)
            hasMoreImageToFetch = page < lastPage
            
            if page == 1 {
                
                // Initial Load...
                
                self.images = flickrPhotos
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.imagesDidLoad()
                }
            
            }else{
                
                // Load More...
                
                let endIndex = images.count + flickrPhotos.count
                let range = images.count..<endIndex
                self.images += flickrPhotos
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.imagesDidUpdate(at: range)
                }
            }
        case .failure(let error):
            print(error.localizedDescription)
            hasMoreImageToFetch = false
            images = []
            
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.imagesDidLoad()
            }
        }
    }
}
