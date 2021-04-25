//
//  InteractiveImageView.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - InteractiveImageView

final class InteractiveImageView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.delegate = self
        return scrollView
    }()
    
    let imageView: UIImageView
    
    // MARK: - Init(s)
    
    init(image: UIImage? = nil) {
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemFill
        imageView.clipsToBounds = true
        
        super.init(frame: .zero)
        
        buildViewHierarchy()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Build View Hierarchy
    
    func buildViewHierarchy() {
        
        // MARK: Scroll View
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        // MARK: Image View
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Update Zoom Scale
    
    func updateZoomScale() {
        self.layoutIfNeeded()
        let widthDelta = self.bounds.size.width / imageView.bounds.size.width
        let heightDelta = self.bounds.size.height / imageView.bounds.size.height
        var minZoom = min(widthDelta, heightDelta)

        if (minZoom > 1.0) {
            minZoom = 1.0;
        }

        scrollView.minimumZoomScale = minZoom;
        scrollView.zoomScale = minZoom;
    }
    
    // MARK: - Overrides
    
    override func layoutSubviews() {
        updateZoomScale()
        super.layoutSubviews()
    }
}

// MARK: - InteractiveImageView+UIScrollViewDelegate

extension InteractiveImageView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

// MARK: - TestInteractiveImageViewViewController

final class TestInteractiveImageViewViewController: UIViewController {
    
    private let interactiveImageView = InteractiveImageView(image: #imageLiteral(resourceName: "sample-image"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupViewHierarchy()
    }
    
    private func setupViewHierarchy() {
        
        // MARK: Interactive Image View
        
        interactiveImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(interactiveImageView)
        interactiveImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        interactiveImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        interactiveImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        interactiveImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
}
