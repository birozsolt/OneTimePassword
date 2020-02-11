//
//  CreateUserViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
    private lazy var createUserView = CreateUserView()
    
    override func loadView() {
        view = createUserView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupHideKeyboardOnTap()
        setupButtonClosures()
    }
    
    private func setupButtonClosures() {
        createUserView.setupContinueButtonAction { _ in
            let baseVC = BaseViewController()
            self.navigationController?.pushViewController(baseVC, animated: true)
        }
    }
}
