//
//  DetailViewController.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 21.10.2026.
//

import UIKit
import InterestingNumbersLibrary

final class DetailViewController: UIViewController {
    
    private let facts: [NumberModel]
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let closeButton = CustomIconButton(imageName: "xmark.circle")
    
    private let titleLabel = CustomLabel(
        text: "",
        fontSize: 32,
        fontWeight: .bold,
        textColor: .white,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private let factLabel = CustomLabel(
        style: .paragraph,
        text: "",
        fontSize: 18,
        fontWeight: .semibold,
        textColor: .white,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    init(facts: [NumberModel]) {
        self.facts = facts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        closeButtonSetup()
        setupScrollView()
        setupStackView()
    }
    
    // MARK: - Layout Setup
    
    private func setupView() {
        view.backgroundColor = .customPurple
        view.accessibilityIdentifier = "detail.view"
        titleLabel.accessibilityIdentifier = "detail.titleLabel"
        factLabel.accessibilityIdentifier = "detail.factLabel"
        closeButton.accessibilityIdentifier = "detail.closeButton"
        configure(with: facts)
    }
    
    private func closeButtonSetup() {
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 12
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -12
            ),
            closeButton.heightAnchor.constraint(
                equalToConstant: 44
            ),
            closeButton.widthAnchor.constraint(
                equalToConstant: 44
            )
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 12
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(factLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 12
            ),
            stackView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 12
            ),
            stackView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -12
            ),
            stackView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -12
            ),
            stackView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -24
            )
        ])
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }
    
    private func configure(with facts: [NumberModel]) {
        guard let first = facts.first else {
            titleLabel.text = "No facts"
            factLabel.text = "The server returned no facts for this request."
            return
        }
        
        if facts.count == 1 {
            titleLabel.text = String(first.number)
            factLabel.text = first.text
        } else {
            let numbers = facts
                .map { String($0.number) }
                .joined(separator: ", ")
            
            titleLabel.text = "Facts for numbers:\n\(numbers)"
            factLabel.text = facts
                .map { "\($0.text)" }
                .joined(separator: "\n\n")
        }
    }
    
}
