//
//  CreateUserView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class CreateUserView: UIView {
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User name:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        textField.isUserInteractionEnabled = true
        textField.clearsOnBeginEditing = true
        textField.autocorrectionType = .no
        textField.textColor = .darkGray
        textField.tintColor = .black
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .darkGray
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        backgroundColor = .lightGray
        setupView()
        userNameTextField.delegate = self
    }
    
    private func setupView() {
        addSubview(userNameTextField)
        addSubview(userNameLabel)
        addSubview(continueButton)
        setupLayout()
    }
    
    private func setupLayout() {
        userNameTextField.autoCenterInSuperview()
        userNameTextField.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        userNameLabel.autoPinEdge(.bottom, to: .top, of: userNameTextField, withOffset: -10)
        userNameLabel.autoPinEdge(.left, to: .left, of: userNameTextField)
        
        continueButton.autoPinEdge(.top, to: .bottom, of: userNameTextField, withOffset: 30)
        continueButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        continueButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
    
    func setupContinueButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        continueButton.addAction(for: .touchUpInside, closure: closure)
    }
    
    func getTextfieldText() -> String? {
        return userNameTextField.text
    }
}

extension CreateUserView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
