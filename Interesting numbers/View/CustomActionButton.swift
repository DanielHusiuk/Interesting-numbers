//
//  CustomActionButton.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit

final class CustomActionButton: UIButton {
    
    init(
        title: String,
        fontSize: CGFloat = 20,
        fontWeight: UIFont.Weight = .semibold,
        titleColor: UIColor = .white,
        buttonColor: UIColor = .tintColor,
        cornerRadius: CGFloat = 18
    ) {
        super.init(frame: .zero)
        setupConfiguration(
            title: title,
            fontSize: fontSize,
            fontWeight: fontWeight,
            titleColor: titleColor,
            buttonColor: buttonColor,
            cornerRadius: cornerRadius
        )
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConfiguration(
        title: String,
        fontSize: CGFloat,
        fontWeight: UIFont.Weight,
        titleColor: UIColor,
        buttonColor: UIColor,
        cornerRadius: CGFloat
    ) {
        var configuration = UIButton.Configuration.filled()
        
        configuration.title = title
        configuration.baseForegroundColor = titleColor
        configuration.baseBackgroundColor = buttonColor
        configuration.background.cornerRadius = cornerRadius
        
        configuration.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = .systemFont(
                ofSize: fontSize,
                weight: fontWeight
            )
            return attributes
        }
        
        self.configuration = configuration
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                options: .curveEaseInOut
            ) {
                self.alpha = self.isHighlighted ? 0.8 : 1.0
                
                self.transform = self.isHighlighted
                ? CGAffineTransform(scaleX: 0.98, y: 0.98)
                : .identity
            }
        }
    }
}
