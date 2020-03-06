//
//  CreateUserViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 28/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CreateUserViewModel: NSObject {
    
    private var userList = [String]()
    
    override init() {
        super.init()
        userList = SecureStorage.shared.getUserList()
    }
    
    func verifyUser(withName name: String) -> Bool {
        return !userList.contains(name)
    }
}
