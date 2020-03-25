//
//  VerificationViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 06/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class VerificationViewController: BaseViewController, NavigationBarProtocol {
    
    // MARK: - Properties
    
    var navBarTitle: String?
    var leftBarButtonItem: NavBarButton?
    var rightBarButtonItem: NavBarButton = NavBarButton()
    
    private lazy var verificationView = VerificationView()
    private var viewModel: VerificationViewModel
    
    // MARK: - Init
    
    init(userName name: String, viewType type: VerificationViewType) {
        viewModel = VerificationViewModel(user: name, type: type)
        super.init(nibName: nil, bundle: nil)
        if type == .test {
            viewModel.getUserData(completion: nil)
        }
        setNavigationAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        view = verificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonClosures()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    // MARK: - Private methods
    
    private func setNavigationAppearance() {
        navBarTitle = viewModel.userName
        leftBarButtonItem = NavBarButton(withType: .back)

        let buttonTitle = viewModel.viewType == .enrollment ? LocalizationKeys.next.rawValue.localized : LocalizationKeys.test.rawValue.localized
        rightBarButtonItem = NavBarButton(withTitle: buttonTitle)
    }
    
    private func setupButtonClosures() {
        var counter = 0
        rightBarButtonItem.addAction(for: .touchUpInside) { [weak self] (item) in
            guard let self = self else { return }
            if let item = item as? NavBarButton {
                if item.currentTitle == LocalizationKeys.save.rawValue.localized {
                    self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                    self.viewModel.saveUserData { (isSuccess) in
                        if isSuccess {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
                
                if item.currentTitle == LocalizationKeys.next.rawValue.localized {
                    self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                    self.verificationView.clearCanvas()
                    counter += 1
                    if counter == 3 {
                        self.rightBarButtonItem.setTitle(LocalizationKeys.save.rawValue.localized, for: .normal)
                    }
                }
                
                if item.currentTitle == LocalizationKeys.test.rawValue.localized {
                    if !self.verificationView.getAllCoordinates().isEmpty() {
                        self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                        
                        var validPassword: [Bool] = []
                        validPassword.append(self.viewModel.testUser(forQuarter: .first))
                        validPassword.append(self.viewModel.testUser(forQuarter: .second))
                        validPassword.append(self.viewModel.testUser(forQuarter: .third))
                        validPassword.append(self.viewModel.testUser(forQuarter: .fourth))
                        
                        if validPassword.allSatisfy({ $0 == true }) {
                            self.showAlert(title: LocalizationKeys.verifySuccessTitle.rawValue.localized,
                                           message: LocalizationKeys.verifySuccessMessage.rawValue.localized) { _ in
                                            self.verificationView.clearCanvas()
                            }
                        } else {
                            self.showAlert(title: LocalizationKeys.verifyFailedTitle.rawValue.localized,
                                           message: LocalizationKeys.verifyFailedMessage.rawValue.localized) { _ in
                                            self.verificationView.clearCanvas()
                            }
                        }
                    } else {
                        self.showAlert(title: LocalizationKeys.verifyInvalidTitle.rawValue.localized,
                                       message: LocalizationKeys.verifyInvalidMessage.rawValue.localized
                                        .replacingOccurrences(of: "@s", with: self.viewModel.userName))
                    }
                }
            }
        }
    }
}
