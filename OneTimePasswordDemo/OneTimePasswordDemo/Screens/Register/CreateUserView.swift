//
//  CreateUserView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class CreateUserView: UIView {
    
    // MARK: - Properties
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizationKeys.userName.rawValue.localized
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = AssetCatalog.getColor(.text)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AssetCatalog.getColor(.textfieldBg)
        textField.clearButtonMode = .whileEditing
        textField.isUserInteractionEnabled = true
        textField.clearsOnBeginEditing = true
        textField.autocorrectionType = .no
        textField.textColor = AssetCatalog.getColor(.text)
        textField.tintColor = AssetCatalog.getColor(.buttonBg)
        return textField
    }()
    
    private lazy var continueButton = OTPButton(withTitle: LocalizationKeys.continue.rawValue.localized)
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.getColor(.background)
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
        setupLayout()
    }
    
    private func setupLayout() {
        userNameTextField.autoCenterInSuperviewMargins()
        userNameTextField.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        userNameLabel.autoPinEdge(.bottom, to: .top, of: userNameTextField, withOffset: -10)
        userNameLabel.autoPinEdge(.left, to: .left, of: userNameTextField)
        
        continueButton.autoPinEdge(.top, to: .bottom, of: userNameTextField, withOffset: 30)
        continueButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        continueButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
}

extension CreateUserView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
