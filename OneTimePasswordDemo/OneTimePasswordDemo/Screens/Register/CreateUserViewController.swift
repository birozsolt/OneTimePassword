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
    var leftBarButtonItem: UIBarButtonItem?
    
    private lazy var createUserView = CreateUserView()
    private lazy var viewModel = CreateUserViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navBarTitle = LocalizationKeys.createUser.rawValue.localized
        leftBarButtonItem = UIBarButtonItem(title: LocalizationKeys.back.rawValue.localized, style: .plain, target: self, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = createUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
    private func setupButtonClosures() {
        createUserView.setupContinueButtonAction { [weak self] _ in
            guard let self = self else { return }
            if let text = self.createUserView.getTextfieldText(), !text.isEmpty {
                if self.viewModel.verifieUser(withName: text) {
                    let baseVC = VerificationViewController(userName: text, viewType: .enrollment, experimentType: .none)
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
