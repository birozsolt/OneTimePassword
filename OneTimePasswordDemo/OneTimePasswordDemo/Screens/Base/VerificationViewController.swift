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
    
    init(userName name: String, viewType type: ViewType, experimentType: ExperimentType) {
        viewModel = VerificationViewModel(user: name, expType: experimentType)
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
                switch self.viewModel.experimentType {
                case .fourVone:
                    guard let currentUser = self.viewModel.currentUser else { return }
                    var dtwDistance = CGFloat.zero
                    for serie in currentUser.samples {
                        dtwDistance += self.viewModel.dtwDistance(serie1: serie.timeSerieQ1.exCoordinates,
                                                                  serie2: self.viewModel.coordinates[0].timeSerieQ1.exCoordinates)
                    }
                    print("Quarter 1: ", dtwDistance / 4)
                    dtwDistance = CGFloat.zero
                    for serie in currentUser.samples {
                        dtwDistance += self.viewModel.dtwDistance(serie1: serie.timeSerieQ2.exCoordinates,
                                                                  serie2: self.viewModel.coordinates[0].timeSerieQ2.exCoordinates)
                    }
                    print("Quarter 2: ", dtwDistance / 4)
                    dtwDistance = CGFloat.zero
                    for serie in currentUser.samples {
                        dtwDistance += self.viewModel.dtwDistance(serie1: serie.timeSerieQ3.exCoordinates,
                                                                  serie2: self.viewModel.coordinates[0].timeSerieQ3.exCoordinates)
                    }
                    print("Quarter 3: ", dtwDistance / 4)
                    dtwDistance = CGFloat.zero
                    for serie in currentUser.samples {
                        dtwDistance += self.viewModel.dtwDistance(serie1: serie.timeSerieQ4.exCoordinates,
                                                                  serie2: self.viewModel.coordinates[0].timeSerieQ4.exCoordinates)
                    }
                    print("Quarter 4: ", dtwDistance / 4)
                case .oneVone:
                    guard let currentUser = self.viewModel.currentUser else { return }
                    var dtwDistance = self.viewModel.dtwDistance(serie1: currentUser.samples[0].timeSerieQ1.exCoordinates,
                                                                 serie2: self.viewModel.coordinates[0].timeSerieQ1.exCoordinates)
                    print("Quarter 1: ", dtwDistance)
                    dtwDistance = self.viewModel.dtwDistance(serie1: currentUser.samples[0].timeSerieQ2.exCoordinates,
                                                             serie2: self.viewModel.coordinates[0].timeSerieQ2.exCoordinates)
                    print("Quarter 2: ", dtwDistance)
                    dtwDistance = self.viewModel.dtwDistance(serie1: currentUser.samples[0].timeSerieQ3.exCoordinates,
                                                             serie2: self.viewModel.coordinates[0].timeSerieQ3.exCoordinates)
                    print("Quarter 3: ", dtwDistance)
                    dtwDistance = self.viewModel.dtwDistance(serie1: currentUser.samples[0].timeSerieQ4.exCoordinates,
                                                             serie2: self.viewModel.coordinates[0].timeSerieQ4.exCoordinates)
                    print("Quarter 4: ", dtwDistance)
                case .none:
                    break
                }
                
            }
        })
    }
}
