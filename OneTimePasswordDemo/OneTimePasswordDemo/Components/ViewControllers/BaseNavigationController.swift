//
//  BaseNavigationController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 17/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

@objc protocol NavigationBarProtocol {
    var navBarTitle: String? { get set }
    var leftBarButtonItem: UIBarButtonItem? { get set }
    @objc optional var rightBarButtonItem: UIBarButtonItem? { get set }
}

class BaseNavigationController: UINavigationController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let vcToPush = viewController as? NavigationBarProtocol {
            viewController.navigationItem.titleView = NavBarTitleLabel(withTitle: vcToPush.navBarTitle)
            viewController.navigationItem.leftBarButtonItem = vcToPush.leftBarButtonItem
            viewController.navigationItem.rightBarButtonItem = vcToPush.rightBarButtonItem ?? UIBarButtonItem()
            vcToPush.leftBarButtonItem?.addTargetClosure { _ in
                self.popViewController(animated: true)
                self.setNavigationBarHidden(self.topViewController is LoginViewController ? true : false, animated: false)
            }
        }
         
        setNavigationBarHidden(viewController is LoginViewController ? true : false, animated: false)
        super.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func setupAppearance() {
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .lightGray
        navigationBar.layer.borderWidth = 0.0
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.darkGray.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 1
    }
}

class NavBarButton: UIButton {
    var alignmentRectInsetsOverride: UIEdgeInsets?
    override var alignmentRectInsets: UIEdgeInsets {
        return alignmentRectInsetsOverride ?? super.alignmentRectInsets
    }
}

class NavBarTitleLabel: UILabel {

    init(withTitle title: String?) {
        super.init(frame: CGRect.zero)
        text = title
        font = UIFont.boldSystemFont(ofSize: 30)
        textColor = .darkGray
        textAlignment = .center
        clipsToBounds = true
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
