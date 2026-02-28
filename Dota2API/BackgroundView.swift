//
//  BackgroundView.swift
//  Dota2API
//
//  Created by Abboskhon Rakhimov on 22/02/26.
//

import UIKit

final class BackgroundView: UIView {
    
    private let imageView = UIImageView()
    private let overlayView = UIView()
    
    init(imageName: String, overlayAlpha: CGFloat = 0.45) {
        super.init(frame: .zero)
        setup(imageName: imageName, overlayAlpha: overlayAlpha)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(imageName: String, overlayAlpha: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(overlayAlpha)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
