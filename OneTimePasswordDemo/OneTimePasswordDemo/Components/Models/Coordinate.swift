//
//  Coordinate.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
class Coordinate: Codable {
    var x: CGFloat
    var y: CGFloat
    var force: CGFloat
    
    init(x: CGFloat, y: CGFloat, force: CGFloat = 0) {
        self.x = x
        self.y = y
        self.force = force
    }
}
