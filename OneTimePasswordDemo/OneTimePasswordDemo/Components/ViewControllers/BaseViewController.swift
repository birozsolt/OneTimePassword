//
//  BaseViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol {
    func setNavigationAppearance()
}

typealias BaseViewController = BaseViewControllerClass & BaseViewControllerProtocol

class BaseViewControllerClass: UIViewController, NavigationBarProtocol {
	
	var navBarTitle: String?
	var leftBarButtonItem: NavBarButton?
	var rightBarButtonItems: [NavBarButton]?
    
	// MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
		guard let controller = self as? BaseViewController else { return }
		controller.setNavigationAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
		guard let controller = self as? BaseViewController else { return }
		controller.setNavigationAppearance()
    }
	
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupHideKeyboardOnTap()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
