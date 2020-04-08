//
//  ResultModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/04/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class ResultModel: Codable {
    
    // MARK: - Properties
    
    var testResults: [Bool] = []
    
    // MARK: - Init
    
    init(_ testResults: [Bool] = []) {
        self.testResults = testResults
    }
    
    // MARK: - Public methods
    
    func reset() {
        testResults.removeAll()
    }
    
    func isValid() -> Bool {
        return testResults.allSatisfy({ $0 == true })
    }
}
