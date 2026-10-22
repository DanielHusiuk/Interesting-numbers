//
//  CustomImage.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit

final class CustomImage: UIView {
    
    private let imageView = UIImageView()
    private let backingView = UIView()
    
    private let backingInsetRatio: CGFloat = 0.1
    private let backingCornerRatio: CGFloat = 0.2
    
    init(imageName: String = "") {
        super.init(frame: .zero)
        setupStyle()
        setupImage(imageName: imageName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
        setupImage(imageName: "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let inset = bounds.width * backingInsetRatio
        backingView.frame = bounds.insetBy(dx: inset, dy: inset)
        backingView.layer.cornerRadius = backingView.bounds.width * backingCornerRatio
    }
    
    private func setupStyle() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        backingView.backgroundColor = .systemBackground
        backingView.layer.cornerCurve = .continuous
        addSubview(backingView)
    }
    
    private func setupImage(imageName: String) {
        addSubview(imageView)
        
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .lightPink
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
