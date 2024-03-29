//
//  CreateUserViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class CreateUserViewController: BaseViewController {
    
    // MARK: - Properties
	
    private lazy var createUserView = CreateUserView()
    private lazy var viewModel = CreateUserViewModel()
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        view = createUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
    // MARK: - Private methods
    
	func setNavigationAppearance() {
        navBarTitle = LocalizationKeys.registerUser.localized
        leftBarButtonItem = NavBarButton(withType: .back)
        rightBarButtonItems?.append(NavBarButton(withType: .settings))
    }
    
    private func setupButtonClosures() {
        createUserView.setupContinueButtonAction { [weak self] _ in
            guard let self = self else { return }
            if let text = self.createUserView.getTextfieldText(), !text.isEmpty {
                if self.viewModel.verifyUser(withName: text) {
                    let baseVC = VerificationViewController(userName: text, viewType: .enrollment)
                    self.navigationController?.pushViewController(baseVC, animated: true)
                } else {
                    self.showAlert(title: LocalizationKeys.error.localized,
                                   message: LocalizationKeys.userAlreadyExist.localized)
                }
            } else {
                self.showAlert(title: LocalizationKeys.warning.localized,
                               message: LocalizationKeys.emptyUserName.localized)
            }
        }
    }
}
