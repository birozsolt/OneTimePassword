//
//  ExtendedCoordinate.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 26/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
class ExtendedCoordinate: Codable {
    
    // MARK: - Properties
    
    var x: CGFloat
    var y: CGFloat
    var force: CGFloat
    var xVelocity: CGFloat
    var yVelocity: CGFloat
    var xAcceleration: CGFloat
    var yAcceleration: CGFloat
    
    // MARK: - Init
    
    init(x: CGFloat, y: CGFloat, force: CGFloat,
         xVelocity: CGFloat, yVelocity: CGFloat,
         xAcceleration: CGFloat, yAcceleration: CGFloat) {
        self.x = x
        self.y = y
        self.force = force
        self.xVelocity = xVelocity
        self.yVelocity = yVelocity
        self.xAcceleration = xAcceleration
        self.yAcceleration = yAcceleration
    }
}

// MARK: - Equatable methods

extension ExtendedCoordinate: Equatable {
    static func == (lhs: ExtendedCoordinate, rhs: ExtendedCoordinate) -> Bool {
        return lhs.x == rhs.x &&
            lhs.xVelocity == rhs.xVelocity &&
            lhs.xAcceleration == rhs.xAcceleration &&
            lhs.y == rhs.y &&
            lhs.yVelocity == rhs.yVelocity &&
            lhs.yAcceleration == rhs.yAcceleration
    }
}
