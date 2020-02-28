//
//  VerificationViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

enum ViewType {
    case enrollment
    case test
}

enum ExperimentType {
    case fourVone
    case oneVone
    case none
}

class VerificationViewModel: NSObject {
    public private(set) var coordinates: [CoordinateModel] = []
    private let userName: String
    public private(set) var currentUser: UserModel?
    public private(set) var experimentType: ExperimentType
    
    init(user: String, expType: ExperimentType) {
        self.userName = user
        self.experimentType = expType
    }
    
    func setCoordinates(coordinates: CoordinateModel) {
        self.coordinates.append(coordinates)
    }
    
    func saveUserData(completion: @escaping (Bool) -> Void) {
        let user = UserModel(name: userName, samples: coordinates)
        SecureStorage.shared.saveUserData(forUser: user) { (isSuccess) in
            if isSuccess {
                completion(true)
            }
            completion(false)
        }
    }
    
    func getUserData(completion: ((Bool) -> Void)?) {
        if let userData = SecureStorage.shared.getUserData(forUser: userName) {
            currentUser = userData
            completion?(true)
        }
        completion?(false)
    }
    
    // swiftlint:disable identifier_name
    private func eucledeanDistance(between exCoord1: ExtendedCoordinate, _ exCoord2: ExtendedCoordinate) -> CGFloat {
        return sqrt(pow((exCoord1.x - exCoord2.x), 2) +
            pow((exCoord1.y - exCoord2.y), 2) +
            pow((exCoord1.xVelocity - exCoord2.xVelocity), 2) +
            pow((exCoord1.yVelocity - exCoord2.yVelocity), 2) +
            pow((exCoord1.xAcceleration - exCoord2.xAcceleration), 2) +
            pow((exCoord1.yAcceleration - exCoord2.yAcceleration), 2))
    }
    
    func dtwDistance(serie1: [ExtendedCoordinate], serie2: [ExtendedCoordinate]) -> CGFloat {
        let n = serie1.count
        let m = serie2.count
        var dtwMatrix = Array(repeating: Array(repeating: CGFloat.greatestFiniteMagnitude, count: m), count: n)
        dtwMatrix[0][0] = 0
        
        for i in 1..<n {
            for j in 1..<m {
                let cost = eucledeanDistance(between: serie1[i], serie2[j])
                dtwMatrix[i][j] = cost + min(dtwMatrix[i - 1][j], dtwMatrix[i][j - 1], dtwMatrix[i - 1][j - 1])
            }
        }
        return dtwMatrix[n - 1][m - 1] / CGFloat(m + n)
    }
    // swiftlint:enable identifier_name
}
