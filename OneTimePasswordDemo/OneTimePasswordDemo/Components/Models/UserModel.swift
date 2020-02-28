//
//  UserModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 17/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class UserModel: Codable {
    var name: String
    var samples: [CoordinateModel]
    
    init(name: String, samples: [CoordinateModel]) {
        self.name = name
        self.samples = samples
    }
}
