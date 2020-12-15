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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = AssetCatalog.color(.text)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AssetCatalog.color(.textfieldBg)
        textField.clearButtonMode = .whileEditing
        textField.isUserInteractionEnabled = true
        textField.clearsOnBeginEditing = true
        textField.autocorrectionType = .no
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = AssetCatalog.color(.text)
        textField.tintColor = AssetCatalog.color(.buttonBg)
        return textField
    }()
    
    private lazy var continueButton = OTPButton(withTitle: LocalizationKeys.continue.localized)
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.color(.background)
        setupView()
        userNameTextField.delegate = self
    }
    
    // MARK: - Public methods
    
    func setupContinueButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        continueButton.addAction(for: .touchUpInside, closure: closure)
    }
    
    func getTextfieldText() -> String? {
        return userNameTextField.text
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
        NSLayoutConstraint.activate([
            userNameTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            userNameTextField.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            userNameTextField.widthAnchor.constraint(equalToConstant: UIConstants.buttonWidth),
            userNameTextField.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight),
            
			userNameLabel.bottomAnchor.constraint(equalTo: userNameTextField.topAnchor, constant: -UIConstants.separatorPadding),
            userNameLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),

			continueButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: UIConstants.verticalPadding),
            continueButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: UIConstants.buttonWidth),
            continueButton.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight)
        ])
    }
}

// MARK: - UITextFieldDelegate methods

extension CreateUserView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
