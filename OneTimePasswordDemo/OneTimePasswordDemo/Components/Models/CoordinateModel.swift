//
//  CoordinateModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 20/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CoordinateModel: Codable {
    var timeSerieQ1: TimeSerieModel
    var timeSerieQ2: TimeSerieModel
    var timeSerieQ3: TimeSerieModel
    var timeSerieQ4: TimeSerieModel
    
    init(coordsQ1: [Coordinate], coordsQ2: [Coordinate], coordsQ3: [Coordinate], coordsQ4: [Coordinate]) {
        timeSerieQ1 = TimeSerieModel()
        timeSerieQ2 = TimeSerieModel()
        timeSerieQ3 = TimeSerieModel()
        timeSerieQ4 = TimeSerieModel()
        timeSerieQ1 = convert(coordsQ1, to: timeSerieQ1)
        timeSerieQ2 = convert(coordsQ2, to: timeSerieQ2)
        timeSerieQ3 = convert(coordsQ3, to: timeSerieQ3)
        timeSerieQ4 = convert(coordsQ4, to: timeSerieQ4)
    }
    
    // swiftlint:disable identifier_name
    private func convert(_ coords: [Coordinate], to timeSerie: TimeSerieModel) -> TimeSerieModel {
        var x = [CGFloat]()
        var y = [CGFloat]()
        var force = [CGFloat]()
        var xVelocity = [CGFloat]()
        var xAcceleration = [CGFloat]()
        var yVelocity = [CGFloat]()
        var yAcceleration = [CGFloat]()
        
        for coord in coords {
            x.append(coord.x)
            y.append(coord.y)
            force.append(coord.force)
        }
        let minX = x.min() ?? 0
        let maxX = x.max() ?? 0
        let normalizedX = x.map { ($0 - minX) / (maxX - minX) }
        
        let minY = y.min() ?? 0
        let maxY = y.max() ?? 0
        let normalizedY = y.map { ($0 - minY) / (maxY - minY) }
        
        xVelocity.append(0)
        yVelocity.append(0)
        for index in 1..<coords.count {
            xVelocity.append(normalizedX[index] - normalizedX[index - 1])
            yVelocity.append(normalizedY[index] - normalizedY[index - 1])
        }
        xAcceleration.append(0)
        xAcceleration.append(0)
        yAcceleration.append(0)
        yAcceleration.append(0)
        for index in 2..<coords.count {
            xAcceleration.append(xVelocity[index] - xVelocity[index - 1])
            yAcceleration.append(yVelocity[index] - yVelocity[index - 1])
        }
        
        for index in 0..<coords.count {
            timeSerie.addCoordinate(coord: ExtendedCoordinate(x: normalizedX[index],
                                                              y: normalizedY[index],
                                                              force: force[index],
                                                              xVelocity: xVelocity[index],
                                                              yVelocity: yVelocity[index],
                                                              xAcceleration: xAcceleration[index],
                                                              yAcceleration: yAcceleration[index]))
        }
        return timeSerie
    }
}
