//
//  UserModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 17/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

struct UserModel {
    private let name: String
    private let samples: [[CoordinateModel]]
    
    init(name: String, samples: [[CoordinateModel]]) {
        self.name = name
        self.samples = samples
    }
    
    func getName() -> String {
        return name
    }
    
    func getSamples() -> [[CoordinateModel]] {
        return samples
    }
}
