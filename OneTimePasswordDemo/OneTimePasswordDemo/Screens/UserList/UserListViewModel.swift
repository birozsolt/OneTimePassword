//
//  UserListViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class UserListViewModel: NSObject {
    private var userList = [String]()
    
    override init() {
        super.init()
        userList = LocalStorage.shared.getUserList()
    }
    
    func numberOfRows() -> Int {
        return userList.count
    }
    
    func userName(forIndex index: Int) -> String {
        return userList[index]
    }
}
