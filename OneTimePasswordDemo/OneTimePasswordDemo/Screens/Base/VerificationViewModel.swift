//
//  VerificationViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 15/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

enum VerificationViewType {
    case enrollment
    case test
}

class VerificationViewModel: NSObject {
    public private(set) var coordinates: [CoordinateModel] = []
    let userName: String
    let viewType: VerificationViewType
    public private(set) var testedUser: UserModel?
    
    typealias AcceptedLimits = (min: CGFloat, max: CGFloat)
    init(user: String, type: VerificationViewType) {
        self.userName = user
        self.viewType = type
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
            testedUser = userData
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
    
    func dtwDistanceCalculator(serie1: [ExtendedCoordinate], serie2: [ExtendedCoordinate]) -> CGFloat {
        let n = serie1.count
        let m = serie2.count
        if n > 0 && m > 0 {
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
        return CGFloat.infinity
    }
    // swiftlint:enable identifier_name
    
    func calculateLimits(forQuarter quarter: Quarters) -> AcceptedLimits {
        guard let testedUser = self.testedUser else { return (min: 0, max: 0) }
        var dtwDistance: [CGFloat] = []
        let countOfSamples = testedUser.samples.count
        for index in 0..<countOfSamples {
            for serie in testedUser.samples {
                if index < (testedUser.samples.firstIndex { $0.self == serie }) ?? 0 {
                    dtwDistance.append(
                        self.dtwDistanceCalculator(serie1: testedUser.samples[index].getSerie(forQuarter: quarter).exCoordinates,
                                         serie2: serie.getSerie(forQuarter: quarter).exCoordinates))
                }
            }
        }
        let count = CGFloat(dtwDistance.count)
        let sumOfArray = dtwDistance.reduce(0, +)
        let avarageDistance = sumOfArray / count
        var sum = CGFloat.zero
        for dist in dtwDistance {
            sum += pow((dist - avarageDistance), 2)
        }
        let variation = sum / count
        let standardDeviation = sqrt(variation)
        return (min: avarageDistance - standardDeviation, max: avarageDistance + standardDeviation)
    }
    
    func testUser(forQuarter quarter: Quarters) -> Bool {
        guard let testedUser = self.testedUser else { return false }
        var distance = CGFloat.zero
        let sampleCount = CGFloat(testedUser.samples.count)
        let limits = calculateLimits(forQuarter: quarter)
        for serie in testedUser.samples {
            distance += dtwDistanceCalculator(serie1: serie.getSerie(forQuarter: quarter).exCoordinates,
                                    serie2: coordinates[0].getSerie(forQuarter: quarter).exCoordinates)
        }
        
        return (limits.min < (distance / sampleCount) && limits.max > (distance / sampleCount)) ? true : false
    }
}
