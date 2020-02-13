//
//  LocalStorage.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 13/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import Locksmith

enum StorageKeys: String {
    case userName
    case userList
    case userData
    case oneTimePasswordAccount
}

class LocalStorage: SecureStorable {
    static let shared = LocalStorage()
    
    private init() {
        
    }
    
    func setUser(withName name: String, completition: @escaping (Bool) -> Void) {
        saveUserList(newName: name)
        completition(true)
    }
    
    func getUser(forName name: String) -> String? {
        guard let userData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else {
            return nil
        }
        return userData[StorageKeys.userName.rawValue] as? String
    }
    
    private func saveUserList(newName name: String) {
        guard var userData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else {
            try? Locksmith.saveData(data: [StorageKeys.userList.rawValue: [name]], forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            return }
        guard var list = userData[StorageKeys.userList.rawValue] as? [String] else {
            userData[StorageKeys.userList.rawValue] = [name]
            try? Locksmith.updateData(data: userData, forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            return
        }
        list.append(name)
        userData[StorageKeys.userList.rawValue] = list
        try? Locksmith.updateData(data: userData, forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
    }
    
    func getUserList() -> [String] {
        guard let userData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else {
            return []
        }
        return (userData[StorageKeys.userList.rawValue] as? [String]) ?? []
    }
}
