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

class VerificationViewModel: NSObject {
    private var coordinates: [CoordinateModel] = []
    private let userName: String
    var currentUser: UserModel!
    
    init(user: String) {
        self.userName = user
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
}
