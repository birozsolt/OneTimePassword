//
//  CoordinateModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 20/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CoordinateModel: Codable {
    public private(set) var timeSerieQ1: TimeSerieModel
    public private(set) var timeSerieQ2: TimeSerieModel
    public private(set) var timeSerieQ3: TimeSerieModel
    public private(set) var timeSerieQ4: TimeSerieModel
    
    init(coordsQ1: [Coordinate], coordsQ2: [Coordinate], coordsQ3: [Coordinate], coordsQ4: [Coordinate]) {
        timeSerieQ1 = TimeSerieModel(coordinates: coordsQ1)
        timeSerieQ2 = TimeSerieModel(coordinates: coordsQ2)
        timeSerieQ3 = TimeSerieModel(coordinates: coordsQ3)
        timeSerieQ4 = TimeSerieModel(coordinates: coordsQ4)
    }
}
