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
    
    init(userName name: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = baseView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
    }
}
