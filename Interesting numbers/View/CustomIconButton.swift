//
//  CustomIconButton.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit

final class CustomIconButton: UIButton {
    
    private let imageName: String
    
    init(imageName: String = "") {
        self.imageName = imageName
        super.init(frame: .zero)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        self.imageName = ""
        super.init(coder: coder)
        setupStyle()
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.alpha = self.isHighlighted ? 0.8 : 1.0
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            })
        }
    }
    
    private func setupStyle() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        tintAdjustmentMode = .normal
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(
            systemName: imageName,
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 20,
                weight: .semibold
            )
        )
        
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .clear
        configuration.contentInsets = .zero
        self.configuration = configuration
    }
}
