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
    
    private lazy var createUserButton = OTPButton(withTitle: LocalizationKeys.registerUser.localized)
    private lazy var verifyUserButton = OTPButton(withTitle: LocalizationKeys.verifyUser.localized)
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AssetCatalog.color(.background)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            $0.centerHorizontal(equalTo: safeAreaLayoutGuide.centerXAnchor)
            $0.widthAnchor(constant: UIConstants.buttonWidth)
            $0.heightAnchor(constant: UIConstants.buttonHeight)
        }
        createUserButton.centerVertical(equalTo: safeAreaLayoutGuide.centerYAnchor)
        verifyUserButton.topAnchor(equalTo: createUserButton.bottomAnchor, constant: UIConstants.verticalPadding)
    }
}
