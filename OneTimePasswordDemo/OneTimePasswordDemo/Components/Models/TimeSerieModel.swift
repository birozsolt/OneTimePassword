//
//  TimeSerieModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 22/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class TimeSerieModel: Codable {
    
    // MARK: - Properties
    
    var exCoordinates: [ExtendedCoordinate] = []
    var minX: CGFloat = 0
    var maxX: CGFloat = 0
    var minY: CGFloat = 0
    var maxY: CGFloat = 0
    var minForce: CGFloat = 0
    var maxForce: CGFloat = 0
    // MARK: - Init
    
    init(with coords: [Coordinate]) {
        
        generate(from: coords)
    }
    
    // MARK: - Public methods
    
    func isEmpty() -> Bool {
        return exCoordinates.isEmpty
    }
    
    func getCoordinates() -> [Coordinate] {
        var xArray = exCoordinates.map { $0.x }
        var yArray = exCoordinates.map { $0.y }
        var forceArray = exCoordinates.map { $0.force }
        let restoredX = xArray.restored(min: minX, max: maxX)
        let restoredY = yArray.restored(min: minY, max: maxY)
        let restoredForce = forceArray.restored(min: minForce, max: maxForce)
        return stride(from: 0, to: restoredX.count, by: 1).map({ Coordinate(x: restoredX[$0],
                                                                            y: restoredY[$0],
                                                                            force: restoredForce[$0])
        })
    }
    
    // MARK: - Private methods
    
    // swiftlint:disable identifier_name
    private func generate(from coords: [Coordinate]) {
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
            minX = x.min() ?? 0
            maxX = x.max() ?? 0
            minY = y.min() ?? 0
            maxY = y.max() ?? 0
            minForce = force.min() ?? 0
            maxForce = force.max() ?? 0
            
            let normalizedX = x.normalized()
            let normalizedY = y.normalized()
            
            xVelocity.append(0)
            xVelocity.append(contentsOf: stride(from: 1, to: coords.count, by: 1).map({ normalizedX[$0] - normalizedX[$0 - 1] }))

            yVelocity.append(0)
            yVelocity.append(contentsOf: stride(from: 1, to: coords.count, by: 1).map({ normalizedY[$0] - normalizedY[$0 - 1] }))

            let arr0: [CGFloat] = Array(repeating: 0, count: 2)
            xAcceleration.append(contentsOf: arr0)
            xAcceleration.append(contentsOf: stride(from: 2, to: coords.count, by: 1).map({ xVelocity[$0] - xVelocity[$0 - 1] }))
            
            yAcceleration.append(contentsOf: arr0)
            yAcceleration.append(contentsOf: stride(from: 2, to: coords.count, by: 1).map({ yVelocity[$0] - yVelocity[$0 - 1] }))
            
            for index in 0..<coords.count {
                exCoordinates.append(ExtendedCoordinate(x: normalizedX[index],
                                                        y: normalizedY[index],
                                                        force: force[index],
                                                        xVelocity: xVelocity[index],
                                                        yVelocity: yVelocity[index],
                                                        xAcceleration: xAcceleration[index],
                                                        yAcceleration: yAcceleration[index]))
            }
        }
    }
}

// MARK: - Equatable methods

extension TimeSerieModel: Equatable {
    static func == (lhs: TimeSerieModel, rhs: TimeSerieModel) -> Bool {
        return lhs.exCoordinates == rhs.exCoordinates
    }
}
