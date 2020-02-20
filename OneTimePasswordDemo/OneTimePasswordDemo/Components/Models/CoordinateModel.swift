//
//  CoordinateModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 20/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CoordinateModel: NSObject, NSCoding {
    private var coordsQ1: [Coordinate]!
    private var coordsQ2: [Coordinate]!
    private var coordsQ3: [Coordinate]!
    private var coordsQ4: [Coordinate]!
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.coordsQ1 = decoder.decodeObject(forKey: "q1") as? [Coordinate]
        self.coordsQ2 = decoder.decodeObject(forKey: "q2") as? [Coordinate]
        self.coordsQ3 = decoder.decodeObject(forKey: "q3") as? [Coordinate]
        self.coordsQ4 = decoder.decodeObject(forKey: "q4") as? [Coordinate]
    }
    
    convenience init(coordsQ1: [Coordinate], coordsQ2: [Coordinate], coordsQ3: [Coordinate], coordsQ4: [Coordinate]) {
        self.init()
        self.coordsQ1 = coordsQ1
        self.coordsQ2 = coordsQ2
        self.coordsQ3 = coordsQ3
        self.coordsQ4 = coordsQ4
    }
    
    func encode(with coder: NSCoder) {
        if let coordsQ1 = coordsQ1 { coder.encode(coordsQ1, forKey: "q1") }
        if let coordsQ2 = coordsQ2 { coder.encode(coordsQ2, forKey: "q2") }
        if let coordsQ3 = coordsQ3 { coder.encode(coordsQ3, forKey: "q3") }
        if let coordsQ4 = coordsQ4 { coder.encode(coordsQ4, forKey: "q4") }
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
