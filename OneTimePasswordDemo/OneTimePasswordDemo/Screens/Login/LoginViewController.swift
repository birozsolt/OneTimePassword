//
//  LoginViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var loginView = LoginView()
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
	func setNavigationAppearance() { }
	
    // MARK: - Private methods
    
    private func setupButtonClosures() {
        loginView.setupCreateUserButtonAction { [weak self]_ in
			guard let self = self else { return }
//            SecureStorage.shared.deleteAllData()
            let createUserVC = CreateUserViewController()
            self.navigationController?.pushViewController(createUserVC, animated: true)
        }
        
        loginView.setupVerifyUserButtonAction { [weak self] _ in
			guard let self = self else { return }
            let userListVC = UserListViewController()
            self.navigationController?.pushViewController(userListVC, animated: true)
        }
    }
}
