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
            if self.verifieUser(withName: self.createUserView.getTextfieldText()) {
                LocalStorage.shared.setUser(withName: self.createUserView.getTextfieldText(), completition: { success in
                    if success {
                        let baseVC = BaseViewController(userName: self.createUserView.getTextfieldText())
                        self.navigationController?.pushViewController(baseVC, animated: true)
                    }
                })
            } else {
                let alert = UIAlertController(title: "Error", message: "User already exist.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func verifieUser(withName name: String) -> Bool {
        let userList = LocalStorage.shared.getUserList()
        return !userList.contains(name)
    }
}
