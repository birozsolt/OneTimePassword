//
//  SecureStorage.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 13/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import Locksmith

enum StorageKeys: String {
    case userName
    case userList
    case oneTimePasswordAccount
}

class SecureStorage: SecureStorable {
    static let shared = SecureStorage()
    typealias LocalStorageCallBack = (Bool) -> Void
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() { }
    
    func setUser(withName name: String, completion: LocalStorageCallBack?) {
        saveUserList(newName: name)
        completion?(true)
    }
    
    func deleteAllData() {
        try? Locksmith.deleteDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue)
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
    
    func saveUserData(forUser user: UserModel, completion: LocalStorageCallBack?) {
        guard let storedData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else {
            do {
                let jsonDataToSave = try encoder.encode(user)
                try Locksmith.saveData(data: [user.name: jsonDataToSave],
                                       forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                print(error)
            }
            setUser(withName: user.name) { (isSuccess) in
                completion?(isSuccess)
            }
            return
        }
        guard (storedData[user.name] as? Data) != nil else {
            do {
                let jsonDataToSave = try encoder.encode(user)
                try Locksmith.saveData(data: [user.name: jsonDataToSave],
                                       forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                print(error)
            }
            setUser(withName: user.name) { (isSuccess) in
                completion?(isSuccess)
            }
            return
        }
    }
    
    func getUserData(forUser name: String) -> UserModel? {
        guard let storedData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else { return nil }
        guard let userData = storedData[name] as? Data else { return nil }
        do {
            let model = try decoder.decode(UserModel.self, from: userData)
            return model
        } catch {
            print(error)
        }
        return nil
    }
}
