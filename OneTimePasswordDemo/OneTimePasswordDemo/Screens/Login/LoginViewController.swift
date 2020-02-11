//
//  LoginViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupButtonClosures()
    }
    
    private func setupButtonClosures() {
        loginView.setupCreateUserButtonAction { _ in
            let createUserVC = CreateUserViewController()
            self.navigationController?.pushViewController(createUserVC, animated: true)
        }
        
        loginView.setupVerifieUserButtonAction { _ in
            let userListVC = UserListViewController()
            self.navigationController?.pushViewController(userListVC, animated: true)
        }
    }
}