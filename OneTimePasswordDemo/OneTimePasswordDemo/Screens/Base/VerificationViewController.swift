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
        navBarTitle = name
        leftBarButtonItem = UIBarButtonItem(title: LeftBarButtonTitle.cancel.rawValue, style: .plain, target: self, action: nil)
        let buttonTitle = type == .enrollment ? RightBarButtonTitle.next.rawValue : RightBarButtonTitle.test.rawValue
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
            if item.title == RightBarButtonTitle.save.rawValue {
                self.viewModel.saveUserData { (isSuccess) in
                    if isSuccess {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            
            if item.title == RightBarButtonTitle.next.rawValue {
                self.viewModel.setCoordinates(coordinates: self.verificationView.getAllCoordinates())
                self.verificationView.clearCanvas()
                counter += 1
                if counter == 3 {
                    self.rightBarButtonItem?.title = RightBarButtonTitle.save.rawValue
                }
            }
            
            if item.title == RightBarButtonTitle.test.rawValue {
                
            }
        })
    }
}
