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
    
    var exCoordinates: [ExtendedCoordinate]
    
    // MARK: - Init
    
    init() {
        exCoordinates = []
    }
    
    // MARK: - Public methods
    
    func addCoordinate(coord: ExtendedCoordinate) {
        exCoordinates.append(coord)
    }
    
    func isEmpty() -> Bool {
        return exCoordinates.isEmpty
    }
}

// MARK: - Equatable methods

extension TimeSerieModel: Equatable {
    static func == (lhs: TimeSerieModel, rhs: TimeSerieModel) -> Bool {
        return lhs.exCoordinates == rhs.exCoordinates
    }
}
