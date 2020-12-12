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
    var normalizationModel: NormalizationModel!
    
    // MARK: - Init
    
    init(with coords: [Coordinate], normModel: NormalizationModel? = nil) {
        generate(from: coords, with: normModel)
    }
    
    // MARK: - Public methods
    
    func isEmpty() -> Bool {
        return exCoordinates.isEmpty
    }
    
    func getCoordinates() -> [Coordinate] {
        var xArray = exCoordinates.map { $0.x }
        var yArray = exCoordinates.map { $0.y }
        var forceArray = exCoordinates.map { $0.force }
        let restoredX = xArray.restored(min: normalizationModel.minX, max: normalizationModel.maxX)
        let restoredY = yArray.restored(min: normalizationModel.minY, max: normalizationModel.maxY)
        let restoredForce = forceArray.restored(min: normalizationModel.minForce, max: normalizationModel.maxForce)
        return stride(from: 0, to: restoredX.count, by: 1).map({ Coordinate(x: restoredX[$0],
                                                                            y: restoredY[$0],
                                                                            force: restoredForce[$0])
        })
    }
    
    // MARK: - Private methods
    
    // swiftlint:disable identifier_name
    private func generate(from coords: [Coordinate], with normModel: NormalizationModel?) {
        if coords.count > 1 {
            var x = Array<CGFloat>()
            var y = Array<CGFloat>()
            var force = Array<CGFloat>()
            var xVelocity = Array<CGFloat>()
            var xAcceleration = Array<CGFloat>()
            var yVelocity = Array<CGFloat>()
            var yAcceleration = Array<CGFloat>()
            
            for coord in coords {
                x.append(coord.x)
                y.append(coord.y)
                force.append(coord.force)
            }
            normalizationModel = NormalizationModel(minX: x.min(), maxX: x.max(),
                                                    minY: y.min(), maxY: y.max(),
                                                    minForce: force.min(), maxForce: force.max())
            var normalizedX = [CGFloat]()
            var normalizedY = [CGFloat]()
            if let normModel = normModel {
                normalizedX = x.normalized(min: normModel.minX, max: normModel.maxX)
                normalizedY = y.normalized(min: normModel.minY, max: normModel.maxY)
            } else {
                normalizedX = x.normalized()
                normalizedY = y.normalized()
            }
            
            let seqFromOne = stride(from: 1, to: coords.count, by: 1)
            xVelocity.append(0)
            yVelocity.append(0)
            for index in seqFromOne {
                let velX = normalizedX[index] - normalizedX[index - 1]
                xVelocity.append(velX)
                
                let velY = normalizedY[index] - normalizedY[index - 1]
                yVelocity.append(velY)
            }

            let arr0: [CGFloat] = Array(repeating: 0, count: 2)
            let seqFromTwo = stride(from: 2, to: coords.count, by: 1)
            xAcceleration.append(contentsOf: arr0)
            yAcceleration.append(contentsOf: arr0)
            for index in seqFromTwo {
                let accX = xVelocity[index] - xVelocity[index - 1]
                xAcceleration.append(accX)
                let accY = yVelocity[index] - yVelocity[index - 1]
                yAcceleration.append(accY)
            }
            
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
