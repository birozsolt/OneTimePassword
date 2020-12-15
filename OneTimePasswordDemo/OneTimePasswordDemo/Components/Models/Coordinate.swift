//
//  Coordinate.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

typealias CoordinateGroup = (q1: [Coordinate], q2: [Coordinate], q3: [Coordinate], q4: [Coordinate])

// swiftlint:disable identifier_name
class Coordinate: Codable {
    
    // MARK: - Properties
    
    var x: CGFloat
    var y: CGFloat
    var force: CGFloat
    
    // MARK: - Init
    
    init(x: CGFloat, y: CGFloat, force: CGFloat = 0) {
        self.x = x
        self.y = y
        self.force = force
    }
}
