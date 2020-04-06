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
