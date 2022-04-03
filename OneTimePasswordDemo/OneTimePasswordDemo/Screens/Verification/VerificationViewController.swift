//
//  VerificationViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 06/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class VerificationViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var verificationView = VerificationView()
    private let viewModel: VerificationViewModel
    
    // MARK: - Init
    
    init(userName name: String, viewType type: VerificationViewType) {
        viewModel = VerificationViewModel(user: name, type: type)
		super.init()
        if type == .test {
            viewModel.getUserData { [ weak self ] (isSuccess) in
                guard let self = self, let testedUser = self.viewModel.testedUser else { return }
                if isSuccess {
                    for sample in testedUser.samples {
                        self.verificationView.drawHelpers(for: sample, sampleCount: testedUser.samples.count)
                    }
                }
            }
        }
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
    
	func setNavigationAppearance() {
        navBarTitle = viewModel.userName
        leftBarButtonItem = NavBarButton(withType: .back)
        rightBarButtonItems.append(NavBarButton(withType: viewModel.viewType == .enrollment ? .next : .test))
        rightBarButtonItems.append(NavBarButton(withType: .eraser))
    }
    
    private func setupButtonClosures() {
        var counter = 0
        for barButtonItem in rightBarButtonItems {
            switch barButtonItem.navBarButtonType {
            case .eraser:
                barButtonItem.addAction(for: .touchUpInside) { [weak self] _ in
                    guard let self = self else { return }
                    self.verificationView.clearCanvas()
                }
            case .test:
                barButtonItem.addAction(for: .touchUpInside) { [weak self] _ in
                    guard let self = self else { return }
                    if self.viewModel.setCoordinates(coordGroup: self.verificationView.getCoordinates()) {
                        self.viewModel.verifyUser()
                        self.verificationView.changeBorderColor(for: self.viewModel.resultModel.testResults)
                        if self.viewModel.resultModel.isValid() {
                            self.showAlert(title: LocalizationKeys.verifySuccessTitle.localized,
                                           message: LocalizationKeys.verifySuccessMessage.localized) { _ in
                                            self.verificationView.clearCanvas()
                                            self.viewModel.clearTestResults()
                            }
                        } else {
                            self.showAlert(title: LocalizationKeys.verifyFailedTitle.localized,
                                           message: LocalizationKeys.verifyFailedMessage.localized) { _ in
                                            self.verificationView.clearCanvas()
                                            self.viewModel.clearTestResults()
                            }
                        }
                    } else {
                        self.showAlert(title: LocalizationKeys.verifyInvalidTitle.localized,
                                       message: LocalizationKeys.verifyInvalidMessage.localized
                                        .replacingOccurrences(of: "@s", with: self.viewModel.userName))
                    }
                }
            case .next:
                barButtonItem.addAction(for: .touchUpInside) { [weak self] _ in
                    guard let self = self else { return }
                    if self.viewModel.setCoordinates(coordGroup: self.verificationView.getCoordinates()) {
                        self.verificationView.clearCanvas()
                        counter += 1
                        if counter == LocalStorage.getIntValue(forKey: .numberOfInput) - 1 {
                            barButtonItem.setNavBar(toType: .save)
                            barButtonItem.addAction(for: .touchUpInside) { [weak self] _ in
                                guard let self = self else { return }
                                if self.viewModel.setCoordinates(coordGroup: self.verificationView.getCoordinates()) {
                                    self.viewModel.saveUserData { (isSuccess) in
                                        if isSuccess {
                                            self.navigationController?.popToRootViewController(animated: true)
                                        } else {
                                            self.showAlert(title: LocalizationKeys.saveFailedTitle.localized, message: "") { _ in
                                                self.navigationController?.popToRootViewController(animated: true)
                                            }
                                        }
                                    }
                                } else {
                                    self.showAlert(title: LocalizationKeys.verifyInvalidTitle.localized,
                                                   message: LocalizationKeys.verifyInvalidMessage.localized
                                                    .replacingOccurrences(of: "@s", with: self.viewModel.userName))
                                }
                            }
                        }
                    } else {
                        self.showAlert(title: LocalizationKeys.verifyInvalidTitle.localized,
                                       message: LocalizationKeys.verifyInvalidMessage.localized
                                        .replacingOccurrences(of: "@s", with: self.viewModel.userName))
                    }
                }
            default:
                break
            }
        }
    }
}
