//
//  UserListViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class UserListViewModel: NSObject {
    
    // MARK: - Properties
    
    private var userList = [String]()
    
    // MARK: - Init
    
    override init() {
        super.init()
        userList = SecureStorage.shared.getUserList()
    }
    
    // MARK: - Public methods
    
    func numberOfRows() -> Int {
        return userList.count
    }
    
    func userName(forIndex index: Int) -> String {
        return userList[index]
    }
}
