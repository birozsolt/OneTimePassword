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

final class VerificationViewModel {
    
    // MARK: - Properties
    
    let userName: String
    let viewType: VerificationViewType
    private(set) var coordinates: [CoordinateModel] = []
    private(set) var testedUser: UserModel?
    private(set) var resultModel = ResultModel()
    
    typealias AcceptedLimits = (min: CGFloat, max: CGFloat)

    // MARK: - Init
    
    init(user: String, type: VerificationViewType) {
        self.userName = user
        self.viewType = type
    }
    
    // MARK: - Public methods
    
    func setCoordinates(coordGroup: CoordinateGroup) -> Bool {
        let coordinateModel = CoordinateModel(coordsQ1: coordGroup.q1, coordsQ2: coordGroup.q2, coordsQ3: coordGroup.q3, coordsQ4: coordGroup.q4,
                                              normModelQ1: viewType == .test ? testedUser?.samples[0].timeSerieQ1.normalizationModel : nil,
                                              normModelQ2: viewType == .test ? testedUser?.samples[0].timeSerieQ2.normalizationModel : nil,
                                              normModelQ3: viewType == .test ? testedUser?.samples[0].timeSerieQ3.normalizationModel : nil,
                                              normModelQ4: viewType == .test ? testedUser?.samples[0].timeSerieQ4.normalizationModel : nil)
        guard coordinateModel.isEmpty() else {
            coordinates.append(coordinateModel)
            return true
        }
        return false
    }
    
    func saveUserData(completion: @escaping (Bool) -> Void) {
        let user = UserModel(name: userName, samples: coordinates)
        SecureStorage.saveUserData(forUser: user) { (isSuccess) in
            completion(isSuccess)
        }
    }
    
    func getUserData(completion: ((Bool) -> Void)?) {
        guard let userData = SecureStorage.getUserData(forUser: userName) else {
            completion?(false)
            return
        }
        testedUser = userData
        completion?(true)
    }
    
    func verifyUser() {
        var results = [Bool]()
        results.append(testUser(forQuarter: .first))
        results.append(testUser(forQuarter: .second))
        results.append(testUser(forQuarter: .third))
        results.append(testUser(forQuarter: .fourth))
        resultModel = ResultModel(results)
    }
    
    func clearTestResults() {
        resultModel.reset()
        coordinates.removeAll()
    }
    
    // MARK: - Private methods
    
    private func testUser(forQuarter quarter: Quarters) -> Bool {
        guard let testedUser = self.testedUser else { return false }
        var distance = CGFloat.zero
        let sampleCount = CGFloat(testedUser.samples.count)
        let limits = calculateLimits(forQuarter: quarter)
        for serie in testedUser.samples {
            distance += dtwDistanceCalculator(serie1: serie.getSerie(forQuarter: quarter).exCoordinates,
                                              serie2: coordinates[0].getSerie(forQuarter: quarter).exCoordinates)
        }
        let avarageDistance = distance / sampleCount
        return (limits.min < avarageDistance && limits.max > avarageDistance) ? true : false
    }
    
    private func eucledeanDistance(between exCoord1: ExtendedCoordinate, _ exCoord2: ExtendedCoordinate) -> CGFloat {
        return sqrt(pow((exCoord1.x - exCoord2.x), 2) +
            pow((exCoord1.y - exCoord2.y), 2) +
            pow((exCoord1.xVelocity - exCoord2.xVelocity), 2) +
            pow((exCoord1.yVelocity - exCoord2.yVelocity), 2) +
            pow((exCoord1.xAcceleration - exCoord2.xAcceleration), 2) +
            pow((exCoord1.yAcceleration - exCoord2.yAcceleration), 2))
    }
    
    // swiftlint:disable identifier_name
    private func dtwDistanceCalculator(serie1: [ExtendedCoordinate], serie2: [ExtendedCoordinate]) -> CGFloat {
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
    
    private func calculateLimits(forQuarter quarter: Quarters) -> AcceptedLimits {
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
}
