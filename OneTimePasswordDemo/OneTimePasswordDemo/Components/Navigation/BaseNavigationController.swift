//
//  BaseNavigationController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 17/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

// MARK: -

@objc protocol NavigationBarProtocol {
    var navBarTitle: String? { get set }
    var leftBarButtonItem: NavBarButton? { get set }
    @objc optional var rightBarButtonItem: NavBarButton { get set }
}

// MARK: -

class BaseNavigationController: UINavigationController {
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let vcToPush = viewController as? NavigationBarProtocol {
            viewController.navigationItem.titleView = NavBarTitleLabel(withTitle: vcToPush.navBarTitle)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: vcToPush.leftBarButtonItem ?? UIView())
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: vcToPush.rightBarButtonItem ?? UIView())
            vcToPush.leftBarButtonItem?.addAction(for: .touchUpInside, closure: { _ in
                self.popViewController(animated: true)
                self.setNavigationBarHidden(self.topViewController is LoginViewController ? true : false, animated: false)
            })
            if vcToPush.rightBarButtonItem?.navBarButtonType == NavBarButtonType.settings {
                vcToPush.rightBarButtonItem?.addAction(for: .touchUpInside, closure: { _ in
                    let settingsVC = SettingsViewController()
                    self.pushViewController(settingsVC, animated: true)
                })
            }
        }
         
        setNavigationBarHidden(viewController is LoginViewController ? true : false, animated: false)
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func setupAppearance() {
        navigationBar.barStyle = .default
        navigationBar.barTintColor = AssetCatalog.getColor(.textfieldBg)
        navigationBar.layer.borderWidth = 0.0
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = AssetCatalog.getColor(.background).cgColor
        navigationBar.layer.shadowOpacity = 0.6
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        navigationBar.layer.shadowRadius = 1
    }
}
