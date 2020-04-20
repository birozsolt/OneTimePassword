//
//  LoginView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    
    // MARK: - Properties
    
    private lazy var createUserButton = OTPButton(withTitle: LocalizationKeys.registerUser.rawValue.localized)
    private lazy var verifyUserButton = OTPButton(withTitle: LocalizationKeys.verifyUser.rawValue.localized)
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.getColor(.background)
        setupView()
    }
    
    // MARK: - Public methods
    
    func setupCreateUserButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        createUserButton.addAction(for: .touchUpInside, closure: closure)
    }
    
    func setupVerifyUserButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        verifyUserButton.addAction(for: .touchUpInside, closure: closure)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(createUserButton)
        addSubview(verifyUserButton)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                $0.widthAnchor.constraint(equalToConstant: UIConstants.buttonWidth),
                $0.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight)
            ])
        }
        NSLayoutConstraint.activate([
            createUserButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
			verifyUserButton.topAnchor.constraint(equalTo: createUserButton.bottomAnchor, constant: UIConstants.verticalPadding)
        ])
    }
}
