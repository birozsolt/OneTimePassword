//
//  UserModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 17/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class UserModel: NSObject, NSCoding {
    private var name: String!
    private var samples: [CoordinateModel]!
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObject(forKey: "name") as? String
        self.samples = decoder.decodeObject(forKey: "samples") as? [CoordinateModel]
    }
    
    convenience init(name: String, samples: [CoordinateModel]) {
        self.init()
        self.name = name
        self.samples = samples
    }
    
    func encode(with coder: NSCoder) {
        if let name = name { coder.encode(name, forKey: "name") }
        if let samples = samples { coder.encode(samples, forKey: "samples") }
    }
    
    func getName() -> String {
        return name
    }
    
    func getSamples() -> [CoordinateModel] {
        return samples
    }
}
