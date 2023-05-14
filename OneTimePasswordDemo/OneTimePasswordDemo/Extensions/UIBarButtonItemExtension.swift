//
//  UIBarButtonItemExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 09/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// Typealias for UIBarButtonItem closure.
    public typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> Void

    private class UIBarButtonItemClosureWrapper: NSObject {
        let closure: UIBarButtonItemTargetClosure
        init(_ closure: @escaping UIBarButtonItemTargetClosure) {
            self.closure = closure
        }
    }

    static var targetClosureKey = "targetClosure"
    
    private var targetClosure: UIBarButtonItemTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &Self.targetClosureKey) as? UIBarButtonItemClosureWrapper else {
                return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &Self.targetClosureKey,
                                     UIBarButtonItemClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    public func addTargetClosure(closure: @escaping UIBarButtonItemTargetClosure) {
        targetClosure = closure
        target = self
        action = #selector(closureAction)
    }
}
