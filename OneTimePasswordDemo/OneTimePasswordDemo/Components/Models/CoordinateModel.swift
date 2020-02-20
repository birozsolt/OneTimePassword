//
//  CoordinateModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 20/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CoordinateModel: Codable {
    private var coordsQ1: [Coordinate]!
    private var coordsQ2: [Coordinate]!
    private var coordsQ3: [Coordinate]!
    private var coordsQ4: [Coordinate]!
    
    init(coordsQ1: [Coordinate], coordsQ2: [Coordinate], coordsQ3: [Coordinate], coordsQ4: [Coordinate]) {
        self.coordsQ1 = coordsQ1
        self.coordsQ2 = coordsQ2
        self.coordsQ3 = coordsQ3
        self.coordsQ4 = coordsQ4
    }
    
    func getQ1Coordinates() -> [Coordinate] {
        return coordsQ1
    }
    
    func getQ2Coordinates() -> [Coordinate] {
        return coordsQ2
    }
    
    func getQ3Coordinates() -> [Coordinate] {
        return coordsQ3
    }
    
    func getQ4Coordinates() -> [Coordinate] {
        return coordsQ4
    }
}
