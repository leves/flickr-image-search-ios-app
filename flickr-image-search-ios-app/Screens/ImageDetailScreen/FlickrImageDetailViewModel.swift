//
//  FlickrImageDetailViewModel.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - FlickrImageDetailViewModel

final class FlickrImageDetailViewModel: IImageDetailViewModel {
    
    private(set) var exifs = [(label: String, value: String)]()
    
    var titleText: String {
        image.wrappedValue.title
    }
    
    var imageURL: URL {
        image.largeImageURL
    }
    
    weak var delegate: IImageDetailViewModelDelegate?
    
    let image: FlickrPhoto
    
    private let flickrService = FlickrService() // TODO: FlickrService is coupled with ViewModel -> decoupled it!!!
    
    // MARK: - Init(s)
    
    init(image: FlickrPhoto) {
        self.image = image
    }
    
    // MARK: - Intent(s)
    
    func loadExifInformation() {
        flickrService.getExif(for: image.wrappedValue) { [weak self] result in
            switch result {
            case .success(let photoInfoSearchResult):
                //print(photoInfoSearchResult)
                
                let cameraInfoLabel = "Camera"
                let cameraInfoValue = photoInfoSearchResult.photo.camera.nilIfEmpty ?? "Unavailable"
                self?.exifs.append((cameraInfoLabel, cameraInfoValue))
                
                for exif in photoInfoSearchResult.photo.exif {
                    switch exif.tag {
                    case "XResolution", "YResolution", "ExposureTime", "FNumber":
                        if let cleanValue = exif.clean?._content {
                            self?.exifs.append((exif.label, cleanValue))
                        }
                    case "WhiteBalance":
                        let cleanValue = exif.raw._content
                        self?.exifs.append((exif.label, cleanValue))
                    default:
                        break
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.exifInformationDidLoad()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                self?.exifs = []
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.exifInformationDidLoad()
                }
            }
        }
    }
    
    func configure(cell: InformationTableViewCell, withData data: (label: String, value: String)) {
        cell.textLabel?.text = data.label
        cell.detailTextLabel?.text = data.value
    }
}
