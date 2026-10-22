//
//  CustomTextField.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit

final class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 18
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.x -= 10
        return rect
    }
    
    private func setupStyle() {
        autocapitalizationType = .none
        keyboardType = .numbersAndPunctuation
        clearButtonMode = .whileEditing
        font = .systemFont(ofSize: 18, weight: .regular)
        textColor = .label
        
        let leadingView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: bounds.height))
        leadingView.backgroundColor = .clear
        leftView = leadingView
        leftViewMode = .always
        
        backgroundColor = .lightPink
        translatesAutoresizingMaskIntoConstraints = false
        setupPlaceholder()
    }
    
    private func setupPlaceholder() {
        let textString = NSAttributedString(
            string: "123...",
            attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.systemGray2.withAlphaComponent(0.5)
            ]
        )
        
        let placeholder = NSMutableAttributedString()
        placeholder.append(textString)
        attributedPlaceholder = placeholder
    }
    
}
