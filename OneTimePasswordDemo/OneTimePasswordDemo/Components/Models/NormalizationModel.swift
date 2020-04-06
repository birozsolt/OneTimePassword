//
//  NormalizationModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 06/04/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class NormalizationModel: Codable {
    
    // MARK: - Properties
    
    var minX: CGFloat
    var maxX: CGFloat
    var minY: CGFloat
    var maxY: CGFloat
    var minForce: CGFloat
    var maxForce: CGFloat
    
    // MARK: - Init
    
    init(minX: CGFloat?, maxX: CGFloat?, minY: CGFloat?, maxY: CGFloat?, minForce: CGFloat?, maxForce: CGFloat?) {
        self.minX = minX ?? 0
        self.maxX = maxX ?? 0
        self.minY = minY ?? 0
        self.maxY = maxY ?? 0
        self.minForce = minForce ?? 0
        self.maxForce = maxForce ?? 0
    }
}
