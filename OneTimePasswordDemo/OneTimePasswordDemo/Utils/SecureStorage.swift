//
//  SecureStorage.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 13/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import Locksmith

enum SecureStorageKeys: String {
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
        try? Locksmith.deleteDataForUserAccount(userAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue)
    }
    
    func getUser(forName name: String) -> String? {
        guard let userData = Locksmith.loadDataForUserAccount(userAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue) else {
            return nil
        }
        return userData[SecureStorageKeys.userName.rawValue] as? String
    }
    
    private func saveUserList(newName name: String) {
        guard var userData = Locksmith.loadDataForUserAccount(userAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue) else {
            try? Locksmith.saveData(data: [SecureStorageKeys.userList.rawValue: [name]],
                                    forUserAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue)
            return }
        guard var list = userData[SecureStorageKeys.userList.rawValue] as? [String] else {
            userData[SecureStorageKeys.userList.rawValue] = [name]
            try? Locksmith.updateData(data: userData, forUserAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue)
            return
        }
        list.append(name)
        userData[SecureStorageKeys.userList.rawValue] = list
        try? Locksmith.updateData(data: userData, forUserAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue)
    }
    
    func getUserList() -> [String] {
        guard let userData = Locksmith.loadDataForUserAccount(userAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue) else {
            return []
        }
        return (userData[SecureStorageKeys.userList.rawValue] as? [String]) ?? []
    }
    
    func saveUserData(forUser user: UserModel, completion: LocalStorageCallBack?) {
        guard var storedData = Locksmith.loadDataForUserAccount(userAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue) else {
            do {
                let jsonDataToSave = try encoder.encode(user)
                try Locksmith.saveData(data: [user.name: jsonDataToSave],
                                       forUserAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                completion?(false)
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
                storedData.updateValue(jsonDataToSave, forKey: user.name)
                try Locksmith.updateData(data: storedData, forUserAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                completion?(false)
                print(error)
            }
            setUser(withName: user.name) { (isSuccess) in
                completion?(isSuccess)
            }
            completion?(false)
            return
        }
    }
    
    func getUserData(forUser name: String) -> UserModel? {
        guard let storedData = Locksmith.loadDataForUserAccount(userAccount: SecureStorageKeys.oneTimePasswordAccount.rawValue) else { return nil }
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
