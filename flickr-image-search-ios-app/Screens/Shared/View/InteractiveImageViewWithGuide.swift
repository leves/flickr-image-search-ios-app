//
//  InteractiveImageViewWithGuide.swift
//  flickr-image-search-ios-app
//
//  Created by Levente Bernáth on 2021. 04. 26..
//

import UIKit

// MARK: - InteractiveImageViewWithGuide

final class InteractiveImageViewWithGuide: InteractiveImageView {
    
    // MARK: - UI Elements
    
    private let fingerTipView1 = FingerTipView()
    private let fingerTipView2 = FingerTipView()
    
    // MARK: - Override Build View Hierarchy
    
    override func buildViewHierarchy() {
        super.buildViewHierarchy()
        
        // MARK: Finger Tip View 1
        
        let horizontalTranslation: CGFloat = FingerTipView.fingerSize / 2
        fingerTipView1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fingerTipView1)
        fingerTipView1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        fingerTipView1.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -horizontalTranslation).isActive = true
        
        // MARK: Finger Tip View 2
        
        fingerTipView2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fingerTipView2)
        fingerTipView2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        fingerTipView2.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: horizontalTranslation).isActive = true
    
        fingerTipView1.alpha = 0
        fingerTipView2.alpha = 0
    }
    
    // MARK: - Animation
    
    func startGuidingAnimation() {
        pinchEffect { [weak self] in
            self?.pinchEffect()
        }
    }
    
    private func pinchEffect(completion: (() -> Void)? = nil) {
        let duration: TimeInterval = 1
        let direction = CGSize(width: 50, height: 25)
        let visibleAlphaValue: CGFloat = 0.8
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.fingerTipView1.alpha = visibleAlphaValue
            self?.fingerTipView1.transform = .init(translationX: -direction.width, y: -direction.height)
            self?.fingerTipView2.alpha = visibleAlphaValue
            self?.fingerTipView2.transform = .init(translationX: direction.width, y: direction.width)
        } completion: { (isSucceed) in
            guard isSucceed else { return }
            UIView.animate(withDuration: duration) { [weak self] in
                self?.fingerTipView1.alpha = 0
                self?.fingerTipView1.transform = .identity
                self?.fingerTipView2.alpha = 0
                self?.fingerTipView2.transform = .identity
            } completion: { (isSucceed) in
                guard isSucceed else { return }
                completion?()
            }
        }
    }
}

// MARK: - InteractiveImageViewWithGuide+FingerTipView

extension InteractiveImageViewWithGuide {
    
    private final class FingerTipView: UIView {
        
        static let fingerSize: CGFloat = 50
        static let fingerOpacity: CGFloat = 0.8
        static let fingerColor = UIColor.darkGray
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = Self.fingerColor
            self.alpha = Self.fingerOpacity
            self.layer.cornerRadius = Self.fingerSize / 2
            self.clipsToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
            self.widthAnchor.constraint(equalToConstant: Self.fingerSize).isActive = true
            self.heightAnchor.constraint(equalToConstant: Self.fingerSize).isActive = true
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
