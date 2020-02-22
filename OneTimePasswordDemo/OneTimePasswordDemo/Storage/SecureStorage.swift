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
    case userData
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
        guard var storedData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else {
            do {
                let jsonDataToSave = try encoder.encode(user)
                try Locksmith.saveData(data: [StorageKeys.userName.rawValue: [jsonDataToSave]],
                                       forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                print(error)
            }
            setUser(withName: user.name) { (isSuccess) in
                completion?(isSuccess)
            }
            return
        }
        guard var dataList = storedData[StorageKeys.userName.rawValue] as? [Data] else {
            do {
                let jsonDataToSave = try encoder.encode(user)
                storedData[StorageKeys.userName.rawValue] = [jsonDataToSave]
                try Locksmith.updateData(data: storedData, forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                print(error)
            }
            setUser(withName: user.name) { (isSuccess) in
                completion?(isSuccess)
            }
            return
        }
        do {
            let jsonDataToSave = try encoder.encode(user)
            dataList.append(jsonDataToSave)
            storedData[StorageKeys.userName.rawValue] = dataList
            try Locksmith.updateData(data: storedData, forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
        } catch {
            print(error)
        }
        setUser(withName: user.name) { (isSuccess) in
            completion?(isSuccess)
        }
    }
    
    func getUserData(forUser name: String) -> UserModel? {
        guard let storedData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else { return nil }
        guard let dataList = storedData[StorageKeys.userName.rawValue] as? [Data] else { return nil }
        do {
            let userData = try dataList.first { (data) -> Bool in
                let model = try decoder.decode(UserModel.self, from: data)
                if model.name == name {
                    return true
                }
                return false
            }
            if let userData = userData {
                let userModel = try decoder.decode(UserModel.self, from: userData)
                return userModel
            }
        } catch {
            print(error)
        }
        return nil
    }
}
