//
//  TimeSerieModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 22/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class TimeSerieModel: Codable {
    var exCoordinates: [ExtendedCoordinate]
    
    init() {
        exCoordinates = []
    }
    
    func addCoordinate(coord: ExtendedCoordinate) {
        exCoordinates.append(coord)
    }
}
