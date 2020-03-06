//
//  LoginView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class LoginView: UIView {
    
    private lazy var createUserButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .darkGray
        button.setTitle(LocalizationKeys.registerUser.rawValue.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var verifyUserButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .darkGray
        button.setTitle(LocalizationKeys.verifyUser.rawValue.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        backgroundColor = .lightGray
        setupView()
    }
    
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
    
    func setupCreateUserButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        createUserButton.addAction(for: .touchUpInside, closure: closure)
    }
    
    func setupVerifyUserButtonAction(closure: @escaping UIControl.UIControlTargetClosure) {
        verifyUserButton.addAction(for: .touchUpInside, closure: closure)
    }
}
