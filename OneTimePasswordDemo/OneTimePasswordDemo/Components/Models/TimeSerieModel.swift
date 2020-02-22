//
//  TimeSerieModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 22/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
class TimeSerieModel: Codable {
    public private(set) lazy var x = [CGFloat]()
    public private(set) lazy var y = [CGFloat]()
    public private(set) lazy var force = [CGFloat]()
    public private(set) lazy var xVelocity = [CGFloat]()
    public private(set) lazy var yVelocity = [CGFloat]()
    public private(set) lazy var xAcceleration = [CGFloat]()
    public private(set) lazy var yAcceleration = [CGFloat]()
    
    init(coordinates: [Coordinate]) {
        for coord in coordinates {
            x.append(coord.x)
            y.append(coord.y)
            force.append(coord.force)
        }
        calculate()
    }
    
    private func calculate() {
        let minX = x.min() ?? 0
        let maxX = x.max() ?? 0
        let normalizedX = x.map { ($0 - minX) / (maxX - minX) }
        
        xVelocity.append(0)
        for index in 1..<x.count {
            xVelocity.append(normalizedX[index] - normalizedX[index - 1])
        }
        xAcceleration.append(0)
        xAcceleration.append(0)
        for index in 2..<xVelocity.count {
            xAcceleration.append(xVelocity[index] - xVelocity[index - 1])
        }
        
        let minY = y.min() ?? 0
        let maxY = y.max() ?? 0
        let normalizedY = y.map { ($0 - minY) / (maxY - minY) }
        
        yVelocity.append(0)
        for index in 1..<y.count {
            yVelocity.append(normalizedY[index] - normalizedY[index - 1])
        }
        yAcceleration.append(0)
        yAcceleration.append(0)
        for index in 2..<yVelocity.count {
            yAcceleration.append(yVelocity[index] - yVelocity[index - 1])
        }
    }
}
