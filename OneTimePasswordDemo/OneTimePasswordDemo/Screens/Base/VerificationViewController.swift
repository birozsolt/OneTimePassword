//
//  VerificationViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 06/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class VerificationViewController: BaseViewController, NavigationBarProtocol {
    var navBarTitle: String?
    var leftBarButtonItem: UIBarButtonItem?
    var rightBarButtonItem: UIBarButtonItem?
    
    private lazy var verificationView = VerificationView()
    private var viewModel: VerificationViewModel
    
    init(userName name: String, viewType type: ViewType) {
        viewModel = VerificationViewModel(user: name)
        super.init(nibName: nil, bundle: nil)
        if type == .test {
            viewModel.getUserData(completion: nil)
        }
        navBarTitle = name
        leftBarButtonItem = UIBarButtonItem(title: LocalizationKeys.cancel.rawValue.localized, style: .plain, target: self, action: nil)
        let buttonTitle = type == .enrollment ? LocalizationKeys.next.rawValue.localized : LocalizationKeys.test.rawValue.localized
        rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = verificationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
    }
    
    private func setupButtonClosures() {
        var counter = 0
        rightBarButtonItem?.addTargetClosure(closure: { (item) in
            if item.title == LocalizationKeys.save.rawValue.localized {
                self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                self.viewModel.saveUserData { (isSuccess) in
                    if isSuccess {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            
            if item.title == LocalizationKeys.next.rawValue.localized {
                self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                self.verificationView.clearCanvas()
                counter += 1
                if counter == 3 {
                    self.rightBarButtonItem?.title = LocalizationKeys.save.rawValue.localized
                }
            }
            
            if item.title == LocalizationKeys.test.rawValue.localized {
                self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                
                var validPassword: [Bool] = []
                validPassword.append(self.viewModel.testUser(forQuarter: .first))
                validPassword.append(self.viewModel.testUser(forQuarter: .second))
                validPassword.append(self.viewModel.testUser(forQuarter: .third))
                validPassword.append(self.viewModel.testUser(forQuarter: .fourth))
                
                if validPassword.allSatisfy({ $0 == true }) {
                    self.showAlert(title: LocalizationKeys.verifySuccessTitle.rawValue.localized,
                                   message: LocalizationKeys.verifySuccessMessage.rawValue.localized)
                } else {
                    self.showAlert(title: LocalizationKeys.verifyFailedTitle.rawValue.localized,
                                   message: LocalizationKeys.verifyFailedMessage.rawValue.localized)
                }
            }
        })
    }
}
