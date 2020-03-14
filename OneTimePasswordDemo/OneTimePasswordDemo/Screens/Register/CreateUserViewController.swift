//
//  CreateUserViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CreateUserViewController: BaseViewController, NavigationBarProtocol {
    var navBarTitle: String?
    var leftBarButtonItem: NavBarButton?
    
    private lazy var createUserView = CreateUserView()
    private lazy var viewModel = CreateUserViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setNavigationAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = createUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
    func setNavigationAppearance() {
        navBarTitle = LocalizationKeys.userList.rawValue.localized
        leftBarButtonItem = NavBarButton(withType: .back)
    }
    
    private func setupButtonClosures() {
        createUserView.setupContinueButtonAction { [weak self] _ in
            guard let self = self else { return }
            if let text = self.createUserView.getTextfieldText(), !text.isEmpty {
                if self.viewModel.verifyUser(withName: text) {
                    let baseVC = VerificationViewController(userName: text, viewType: .enrollment)
                    self.navigationController?.pushViewController(baseVC, animated: true)
                } else {
                    self.showAlert(title: LocalizationKeys.error.rawValue.localized,
                                   message: LocalizationKeys.userAlreadyExist.rawValue.localized)
                }
            } else {
                self.showAlert(title: LocalizationKeys.warning.rawValue.localized,
                               message: LocalizationKeys.emptyUserName.rawValue.localized)
            }
        }
    }
}
