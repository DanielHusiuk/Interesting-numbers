//
//  ViewController.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    private let titleStackView = UIStackView()
    private let imageContainerView = UIView()
    
    private let topStackView = UIStackView()
    private let bottomStackView = UIStackView()
    
    private let firstImage = CustomImage(imageName: "die.face.1")
    private let secondImage = CustomImage(imageName: "die.face.5")
    private let segmentedControl = CustomSegmentedControl()
    private let textField = CustomTextField()
    
    private let apiService: ApiServiceProtocol = ApiService(apiManager: ApiManager())
    private let factType: FactType = .trivia
    
    private let titleLabel = CustomLabel(
        text: "Interesting Numbers",
        fontSize: 32,
        fontWeight: .bold,
        textColor: .label
    )
    
    private let subtitleLabel = CustomLabel(
        text: "This App about facts of Numbers\nand Dates",
        fontSize: 18,
        fontWeight: .semibold,
        textColor: .secondaryLabel,
        numberOfLines: 2
    )
    
    private let headerLabel = CustomLabel(
        text: "Enter here",
        fontSize: 16,
        fontWeight: .semibold,
        textColor: .label,
        textAlignment: .left
    )
    
    private let actionButton = CustomActionButton(
        title: "Display Fact",
        fontSize: 20,
        fontWeight: .semibold,
        buttonColor: .tintColor,
        cornerRadius: 18
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTitleStackView()
        setupImageContainerView()
        setupTopStackView()
        setupBottomStackView()
    }
    
    // MARK: - Layout Setup
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        textField.delegate = self
        updateInterfaceState()
    }
    
    private func setupTitleStackView() {
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        titleStackView.alignment = .fill
        titleStackView.distribution = .fill
        titleStackView.spacing = 12
    }
    
    private func setupImageContainerView() {
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.addSubview(firstImage)
        imageContainerView.addSubview(secondImage)
        
        secondImage.transform = CGAffineTransform(
            rotationAngle: .pi / 4
        )
        
        NSLayoutConstraint.activate([
            imageContainerView.heightAnchor.constraint(
                equalToConstant: 160
            ),
            
            firstImage.widthAnchor.constraint(
                equalToConstant: 140
            ),
            firstImage.heightAnchor.constraint(
                equalToConstant: 140
            ),
            firstImage.centerXAnchor.constraint(
                equalTo: imageContainerView.centerXAnchor,
                constant: 35
            ),
            firstImage.centerYAnchor.constraint(
                equalTo: imageContainerView.centerYAnchor,
                constant: 20
            ),
            
            secondImage.widthAnchor.constraint(
                equalToConstant: 140
            ),
            secondImage.heightAnchor.constraint(
                equalToConstant: 140
            ),
            secondImage.centerXAnchor.constraint(
                equalTo: imageContainerView.centerXAnchor,
                constant: -40
            ),
            secondImage.centerYAnchor.constraint(
                equalTo: imageContainerView.centerYAnchor,
                constant: -25
            )
        ])
    }
    
    private func setupTopStackView() {
        view.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .vertical
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.spacing = 90
        
        topStackView.addArrangedSubview(titleStackView)
        topStackView.addArrangedSubview(imageContainerView)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 12
            ),
            topStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12
            )
        ])
    }
    
    private func setupBottomStackView() {
        view.addSubview(bottomStackView)
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.backgroundColor = .systemBackground
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .fill
        bottomStackView.distribution = .fill
        bottomStackView.spacing = 14
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        bottomStackView.addArrangedSubview(segmentedControl)
        bottomStackView.addArrangedSubview(headerLabel)
        bottomStackView.addArrangedSubview(textField)
        bottomStackView.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12
            ),
            bottomStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12
            ),
            bottomStackView.bottomAnchor.constraint(
                equalTo: view.keyboardLayoutGuide.topAnchor,
                constant: -12
            ),
            
            segmentedControl.heightAnchor.constraint(
                equalToConstant: 88
            ),
            headerLabel.heightAnchor.constraint(
                equalToConstant: 20
            ),
            textField.heightAnchor.constraint(
                equalToConstant: 52
            ),
            actionButton.heightAnchor.constraint(
                equalToConstant: 60
            )
        ])
        
        let bottomConstraint = bottomStackView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -24
        )
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }
    
    // MARK: - Actions
    
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func updateInterfaceState() {
        segmentedControl.onSelectionChanged = { [weak self] index in
            guard let self else { return }
            
            if index == 1 {
                self.view.endEditing(true)
                self.textField.text = nil
                self.textField.isEnabled = false
                self.textField.alpha = 0.5
                self.headerLabel.alpha = 0.5
            } else {
                self.textField.isEnabled = true
                self.textField.alpha = 1.0
                self.headerLabel.alpha = 1.0
            }
        }
    }
    
    @objc private func actionButtonTapped() {
        view.endEditing(true)
        let request: RequestType
        do {
            request = try makeRequest()
        } catch {
            showAlert(message: error.localizedDescription)
            return
        }
        
        actionButton.isEnabled = false
        apiService.fetchFacts(for: request, type: factType) { [weak self] result in
            guard let self else { return }
            self.actionButton.isEnabled = true
            
            switch result {
            case .success(let facts):
                self.present(DetailViewController(facts: facts), animated: true)
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func makeRequest() throws -> RequestType {
        let index = segmentedControl.selectedIndex
        if index == 1 { return .random }
        
        let text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { throw InputError.emptyInput }
        let numbers = parseNumbers(from: text)
        
        switch index {
        case 0:
            guard let numbers, numbers.count == 1 else { throw InputError.invalidSingle }
            return .number(numbers[0])
        case 2:
            guard let numbers, numbers.count == 2, numbers[0] <= numbers[1] else {
                throw InputError.invalidRange
            }
            return .range(start: numbers[0], end: numbers[1])
        default:
            guard let numbers, !numbers.isEmpty else { throw InputError.invalidList }
            return .multiple(numbers)
        }
    }
    
    private func parseNumbers(from text: String) -> [Int]? {
        let parts = text
            .components(separatedBy: CharacterSet(charactersIn: ",- "))
            .filter { !$0.isEmpty }
        let numbers = parts.compactMap { Int($0) }
        return numbers.count == parts.count ? numbers : nil
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private enum InputError: LocalizedError {
        case emptyInput
        case invalidSingle
        case invalidRange
        case invalidList
        
        var errorDescription: String? {
            switch self {
            case .emptyInput:
                return "Enter a number first."
            case .invalidSingle:
                return "Enter a single whole number, for example 42."
            case .invalidRange:
                return "Enter two numbers: start and end, for example 1-10. Start must not be greater than end."
            case .invalidList:
                return "Enter numbers separated by commas, for example 5, 10, 42."
            }
        }
    }
}

// MARK: - Extensions

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        actionButtonTapped()
        return true
    }
}
