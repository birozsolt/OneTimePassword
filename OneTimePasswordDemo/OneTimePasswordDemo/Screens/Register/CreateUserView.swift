//
//  CreateUserView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class CreateUserView: UIView {
    
    // MARK: - Properties
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizationKeys.userName.localized
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = AssetCatalog.color(.text)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AssetCatalog.color(.textfieldBg)
        textField.clearButtonMode = .whileEditing
        textField.clearsOnBeginEditing = true
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 20)
        textField.textColor = AssetCatalog.color(.text)
        textField.tintColor = AssetCatalog.color(.buttonBg)
        return textField
    }()
    
    private lazy var continueButton = OTPButton(withTitle: LocalizationKeys.continue.localized)
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AssetCatalog.color(.background)
        setupView()
        userNameTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    
    func setupContinueButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        continueButton.addAction(for: .touchUpInside, closure: closure)
    }
    
    func getTextfieldText() -> String? {
        userNameTextField.text
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(userNameTextField)
        addSubview(userNameLabel)
        addSubview(continueButton)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        userNameTextField.centerVertical(equalTo: safeAreaLayoutGuide.centerYAnchor)
            .centerHorizontal(equalTo: safeAreaLayoutGuide.centerXAnchor)
            .widthAnchor(constant: UIConstants.buttonWidth)
            .heightAnchor(constant: UIConstants.buttonHeight)

        userNameLabel.bottomAnchor(equalTo: userNameTextField.topAnchor, constant: -UIConstants.separatorPadding)
            .leadingAnchor(equalTo: userNameTextField.leadingAnchor)

        continueButton.topAnchor(equalTo: userNameTextField.bottomAnchor, constant: UIConstants.verticalPadding)
            .centerHorizontal(equalTo: safeAreaLayoutGuide.centerXAnchor)
            .widthAnchor(constant: UIConstants.buttonWidth)
            .heightAnchor(constant: UIConstants.buttonHeight)
    }
}

// MARK: - UITextFieldDelegate methods

extension CreateUserView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
