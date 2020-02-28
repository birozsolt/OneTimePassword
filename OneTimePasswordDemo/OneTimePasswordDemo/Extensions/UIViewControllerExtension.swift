//
//  UIViewControllerExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Show an alert popup on the UIViewController
    func showAlert(title: String, message: String, okButtonTitle: String? = LocalizationKeys.oke.rawValue.localized, cancelButtonTitle: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let okTitle = okButtonTitle {
            let okButton = UIAlertAction(title: okTitle, style: .default, handler: nil)
            alert.addAction(okButton)
        }
        if let cancelTitle = cancelButtonTitle {
            let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alert.addAction(cancelButton)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        view.addGestureRecognizer(endEditingRecognizer())
        navigationController?.navigationBar.addGestureRecognizer(endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
