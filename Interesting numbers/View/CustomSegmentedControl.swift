//
//  CustomSegmentedControl.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit
import InterestingNumbersLibrary

final class CustomSegmentedControl: UIView {
    
    private let stackView = UIStackView()
    private var buttons: [UIButton] = []
    
    private let selectedColor = UIColor.tintColor
    private let normalColor = UIColor.lightPink
    
    private var selectedIndex = 0
    var selectedMode: RequestMode { segments[selectedIndex].mode }
    var onSelectionChanged: ((RequestMode) -> Void)?
    
    private let segments: [(title: String, mode: RequestMode)] = [
        ("User\nnumber", .single),
        ("Random\nnumber", .random),
        ("Number\nin a range", .range),
        ("Multiple\nnumbers", .multiple)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupStackView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
        setupStackView()
        setupButtons()
    }
    
    private func setupStyle() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupButtons() {
        for (index, segment) in segments.enumerated() {
            let button = UIButton(type: .system)
            
            button.setTitle(segment.title, for: .normal)
            button.titleLabel?.font = .systemFont(
                ofSize: 16,
                weight: .semibold
            )
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 18
            button.tag = index
            button.accessibilityIdentifier = "main.segment.\(index)"
            button.addTarget(
                self,
                action: #selector(segmentTapped(_:)),
                for: .touchUpInside
            )
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        updateSelection(selectedIndex: 0)
    }
    
    // MARK: - Actions
    
    @objc private func segmentTapped(_ sender: UIButton) {
        updateSelection(selectedIndex: sender.tag)
    }
    
    private func updateSelection(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        for (index, button) in buttons.enumerated() {
            let isSelected = index == selectedIndex
            
            button.backgroundColor = isSelected
            ? selectedColor
            : normalColor
            
            button.setTitleColor(
                isSelected ? .white : .label,
                for: .normal
            )
        }
        onSelectionChanged?(selectedMode)
    }
}
