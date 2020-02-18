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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navBarTitle = "Create user"
        leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
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
        createUserView.setupContinueButtonAction { _ in
            if let text = self.createUserView.getTextfieldText(), !text.isEmpty {
                if self.verifieUser(withName: text) {
                    let baseVC = VerificationViewController(userName: text, viewType: .enrollment)
                    self.navigationController?.pushViewController(baseVC, animated: true)
                } else {
                    let alert = UIAlertController(title: "Error", message: "User already exist.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Warning", message: "You must type a user name to continue.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func verifieUser(withName name: String) -> Bool {
        let userList = SecureStorage.shared.getUserList()
        return !userList.contains(name)
    }
}
