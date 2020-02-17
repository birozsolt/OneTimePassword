//
//  BaseViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupHideKeyboardOnTap()
    }
}
