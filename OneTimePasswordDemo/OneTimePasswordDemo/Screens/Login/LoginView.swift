//
//  LoginView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class LoginView: UIView {
    
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
        setupLayout()
    }
    
    private func setupLayout() {
        createUserButton.autoCenterInSuperviewMargins()
        createUserButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        verifyUserButton.autoPinEdge(.top, to: .bottom, of: createUserButton, withOffset: 30)
        verifyUserButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        verifyUserButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
}
