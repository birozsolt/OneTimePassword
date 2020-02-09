//
//  BaseViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 06/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private lazy var baseView = BaseView()
    
    override func loadView() {
        view = baseView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
    }
}
