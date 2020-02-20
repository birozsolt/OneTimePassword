//
//  LoginViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, NavigationBarProtocol {
    var navBarTitle: String?
    var leftBarButtonItem: UIBarButtonItem?
    
    private lazy var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
    private func setupButtonClosures() {
        loginView.setupCreateUserButtonAction { _ in
//            SecureStorage.shared.deleteAllData()
            let createUserVC = CreateUserViewController()
            self.navigationController?.pushViewController(createUserVC, animated: true)
        }
        
        loginView.setupVerifieUserButtonAction { _ in
            let userListVC = UserListViewController()
            self.navigationController?.pushViewController(userListVC, animated: true)
        }
    }
}
