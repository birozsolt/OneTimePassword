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
        loginView.createUserButton.addAction(for: .touchUpInside) { (_) in
            let baseVC = BaseViewController()
            self.navigationController?.pushViewController(baseVC, animated: true)
        }
    }
}
