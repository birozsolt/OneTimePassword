//
//  UINavigationControllerExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 25/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        guard let visibleVC = visibleViewController else {
            return super.shouldAutorotate
        }
        return visibleVC.shouldAutorotate
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        guard let visibleVC = visibleViewController else {
            return super.preferredInterfaceOrientationForPresentation
        }
        return visibleVC.preferredInterfaceOrientationForPresentation
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let visibleVC = visibleViewController else {
            return super.supportedInterfaceOrientations
        }
        return visibleVC.supportedInterfaceOrientations
    }
}
