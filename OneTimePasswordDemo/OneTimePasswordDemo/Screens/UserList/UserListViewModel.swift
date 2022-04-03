//
//  UserListViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class UserListViewModel {
    
    // MARK: - Properties
    
    private var userList = [String]()
    
    // MARK: - Init
    
    init() {
        userList = SecureStorage.getUserList()
    }
    
    // MARK: - Public methods
    
    func numberOfRows() -> Int {
        userList.count
    }
    
    func userName(forIndex index: Int) -> String {
        userList[index]
    }
}
