//
//  CustomLabel.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit

enum Style {
    case regular
    case paragraph
}

final class CustomLabel: UILabel {
    
    private let style: Style
    
    init(
        style: Style = .regular,
        text: String,
        fontSize: CGFloat = 16,
        fontWeight: UIFont.Weight = .bold,
        textColor: UIColor = .white,
        textAlignment: NSTextAlignment = .center,
        numberOfLines: Int = 1
    ) {
        self.style = style
        super.init(frame: .zero)
        
        self.text = text
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        self.style = .regular
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
        backgroundColor = .clear
        
        if style == .paragraph {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            paragraphStyle.alignment = textAlignment
            
            attributedText = NSAttributedString(
                string: text ?? "",
                attributes: [
                    .font: font ?? .systemFont(ofSize: 16),
                    .foregroundColor: textColor ?? .label,
                    .paragraphStyle: paragraphStyle
                ]
            )
        }
    }
}
