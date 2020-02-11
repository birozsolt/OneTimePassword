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
        userList.append("Test1")
        userList.append("Test2")
        userList.append("Test3")
    }
    
    func numberOfRows() -> Int {
        return userList.count
    }
    
    func userName(forIndex index: Int) -> String {
        return userList[index]
    }
}
