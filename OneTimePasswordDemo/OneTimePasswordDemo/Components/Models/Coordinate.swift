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
    public private(set) var x: CGFloat
    public private(set) var y: CGFloat
    public private(set) var force: CGFloat
    
    init(x: CGFloat, y: CGFloat, force: CGFloat = 0) {
        self.x = x
        self.y = y
        self.force = force
    }
}
