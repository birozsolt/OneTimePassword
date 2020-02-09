//
//  LoginView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class LoginView: UIView {
    
    lazy var createUserButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .darkGray
        button.setTitle("Create user", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var verifieUserButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .darkGray
        button.setTitle("Verifie user", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        backgroundColor = .lightGray
        setupView()
    }
    
    func setupView() {
        addSubview(createUserButton)
        addSubview(verifieUserButton)
        setupLayout()
    }
    
    func setupLayout() {
        createUserButton.autoCenterInSuperview()
        createUserButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        verifieUserButton.autoPinEdge(.top, to: .bottom, of: createUserButton, withOffset: 30)
        verifieUserButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        verifieUserButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
}
