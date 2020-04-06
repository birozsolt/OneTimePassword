//
//  VerificationViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 06/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class VerificationViewController: BaseViewController, NavigationBarProtocol {
    
    // MARK: - Properties
    
    var navBarTitle: String?
    var leftBarButtonItem: NavBarButton?
    var rightBarButtonItems: [NavBarButton] = []
    
    private lazy var verificationView = VerificationView()
    private var viewModel: VerificationViewModel
    
    // MARK: - Init
    
    init(userName name: String, viewType type: VerificationViewType) {
        viewModel = VerificationViewModel(user: name, type: type)
        super.init(nibName: nil, bundle: nil)
        if type == .test {
            viewModel.getUserData { [ weak self ] (isSuccess) in
                guard let self = self, let testedUser = self.viewModel.testedUser else { return }
                if isSuccess {
                    for sample in testedUser.samples {
                        self.verificationView.drawHelpers(forQuarter: .first,
                                                          from: sample.getSerie(forQuarter: .first).getCoordinates())
                        self.verificationView.drawHelpers(forQuarter: .second,
                                                          from: sample.getSerie(forQuarter: .second).getCoordinates())
                        self.verificationView.drawHelpers(forQuarter: .third,
                                                          from: sample.getSerie(forQuarter: .third).getCoordinates())
                        self.verificationView.drawHelpers(forQuarter: .fourth,
                                                          from: sample.getSerie(forQuarter: .fourth).getCoordinates())
                    }
                }
            }
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
                    if self.viewModel.setCoordinates(coordsQ1: self.verificationView.getCoordinates(forQuarter: .first),
                                                     coordsQ2: self.verificationView.getCoordinates(forQuarter: .second),
                                                     coordsQ3: self.verificationView.getCoordinates(forQuarter: .third),
                                                     coordsQ4: self.verificationView.getCoordinates(forQuarter: .fourth)) {
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
            case .next:
                barButtonItem.addAction(for: .touchUpInside) { [weak self] _ in
                    guard let self = self else { return }
                    if self.viewModel.setCoordinates(coordsQ1: self.verificationView.getCoordinates(forQuarter: .first),
                                                     coordsQ2: self.verificationView.getCoordinates(forQuarter: .second),
                                                     coordsQ3: self.verificationView.getCoordinates(forQuarter: .third),
                                                     coordsQ4: self.verificationView.getCoordinates(forQuarter: .fourth)) {        
                        self.verificationView.clearCanvas()
                        counter += 1
                        if counter == (Int(LocalStorage.shared.getValue(forKey: .numberOfInput) as? String ?? "1") ?? 1) - 1 {
                            barButtonItem.setNavBar(toType: .save)
                            barButtonItem.addAction(for: .touchUpInside) { [weak self] _ in
                                guard let self = self else { return }
                                if self.viewModel.setCoordinates(coordsQ1: self.verificationView.getCoordinates(forQuarter: .first),
                                                                 coordsQ2: self.verificationView.getCoordinates(forQuarter: .second),
                                                                 coordsQ3: self.verificationView.getCoordinates(forQuarter: .third),
                                                                 coordsQ4: self.verificationView.getCoordinates(forQuarter: .fourth)) {
                                    self.viewModel.saveUserData { (isSuccess) in
                                        if isSuccess {
                                            self.navigationController?.popToRootViewController(animated: true)
                                        }
                                    }
                                } else {
                                    self.showAlert(title: LocalizationKeys.verifyInvalidTitle.rawValue.localized,
                                                   message: LocalizationKeys.verifyInvalidMessage.rawValue.localized
                                                    .replacingOccurrences(of: "@s", with: self.viewModel.userName))
                                }
                            }
                        }
                    } else {
                        self.showAlert(title: LocalizationKeys.verifyInvalidTitle.rawValue.localized,
                                       message: LocalizationKeys.verifyInvalidMessage.rawValue.localized
                                        .replacingOccurrences(of: "@s", with: self.viewModel.userName))
                    }
                }
            default:
                break
            }
        }
    }
}
