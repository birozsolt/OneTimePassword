//
//  CoordinateModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
class CoordinateModel: NSObject, NSCoding {
    private var x: CGFloat!
    private var y: CGFloat!
    private var force: CGFloat!
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.x = decoder.decodeObject(forKey: "x") as? CGFloat
        self.y = decoder.decodeObject(forKey: "y") as? CGFloat
        self.force = decoder.decodeObject(forKey: "force") as? CGFloat
    }
    
    convenience init(x: CGFloat, y: CGFloat, force: CGFloat = 0) {
        self.init()
        self.x = x
        self.y = y
        self.force = force
    }
    
    func encode(with coder: NSCoder) {
        if let x = x { coder.encode(x, forKey: "x") }
        if let y = y { coder.encode(y, forKey: "y") }
        if let force = force { coder.encode(force, forKey: "force") }
    }
    
    func getXCoordinate() -> CGFloat {
        return x
    }
    
    func getYCoordinate() -> CGFloat {
        return y
    }
    
    func getTouchForce() -> CGFloat {
        return force
    }
}
