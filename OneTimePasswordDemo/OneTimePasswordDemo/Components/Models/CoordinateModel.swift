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
        if coords.count > 1 {
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
        }
        return timeSerie
    }
    
    func getSerie(forQuarter quarter: Quarters) -> TimeSerieModel {
        switch quarter {
        case .first:
            return timeSerieQ1
        case .second:
            return timeSerieQ2
        case .third:
            return timeSerieQ3
        case .fourth:
            return timeSerieQ4
        }
    }
    
    func isEmpty() -> Bool {
        return timeSerieQ1.isEmpty() || timeSerieQ2.isEmpty() || timeSerieQ3.isEmpty() || timeSerieQ4.isEmpty()
    }
}

extension CoordinateModel: Equatable {
    static func == (lhs: CoordinateModel, rhs: CoordinateModel) -> Bool {
        return lhs.timeSerieQ1 == rhs.timeSerieQ1 &&
            lhs.timeSerieQ2 == rhs.timeSerieQ2 &&
            lhs.timeSerieQ3 == rhs.timeSerieQ3 &&
            lhs.timeSerieQ4 == rhs.timeSerieQ4
    }
}
