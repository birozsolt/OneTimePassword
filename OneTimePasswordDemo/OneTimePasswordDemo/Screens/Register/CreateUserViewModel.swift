//
//  CreateUserViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 28/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class CreateUserViewModel {
    
    // MARK: - Properties
    
    private var userList = [String]()
    
    // MARK: - Init
    
    init() {
        userList = SecureStorage.getUserList()
    }
    
    // MARK: - Public methods
    
    func verifyUser(withName name: String) -> Bool {
        !userList.contains(name)
    }
}
