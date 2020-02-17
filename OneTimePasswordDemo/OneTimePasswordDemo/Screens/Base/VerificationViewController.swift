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
    
    private lazy var baseView = VerificationView()
    
    init(userName name: String, viewType type: ViewType) {
        super.init(nibName: nil, bundle: nil)
        navBarTitle = name
        leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        let buttonTitle = type == .enrollment ? "Save" : "Test"
        rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = baseView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
