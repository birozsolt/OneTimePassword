//
//  LoginViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, NavigationBarProtocol {
    
    // MARK: - Properties
    
    var navBarTitle: String?
    var leftBarButtonItem: NavBarButton?
    
    private lazy var loginView = LoginView()
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
    // MARK: - Private methods
    
    private func setupButtonClosures() {
        loginView.setupCreateUserButtonAction { _ in
//            SecureStorage.shared.deleteAllData()
            let createUserVC = CreateUserViewController()
            self.navigationController?.pushViewController(createUserVC, animated: true)
        }
        
        loginView.setupVerifyUserButtonAction { _ in
            let userListVC = UserListViewController()
            self.navigationController?.pushViewController(userListVC, animated: true)
        }
    }
}
