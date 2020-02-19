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
                let userDataToSave = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
                try Locksmith.saveData(data: [StorageKeys.userName.rawValue: [userDataToSave]],
                                       forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                print(error)
            }
            setUser(withName: user.getName()) { (isSuccess) in
                if isSuccess {
                    completion?(true)
                }
                completion?(false)
            }
            return
        }
        guard var dataList = storedData[StorageKeys.userName.rawValue] as? [Data] else {
            do {
                let userDataToSave = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
                storedData[StorageKeys.userName.rawValue] = [userDataToSave]
                try Locksmith.updateData(data: storedData, forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
            } catch {
                print(error)
            }
            setUser(withName: user.getName()) { (isSuccess) in
                if isSuccess {
                    completion?(true)
                }
                completion?(false)
            }
            return
        }
        do {
            let userDataToSave = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            dataList.append(userDataToSave)
            storedData[StorageKeys.userName.rawValue] = dataList
            try Locksmith.updateData(data: storedData, forUserAccount: StorageKeys.oneTimePasswordAccount.rawValue)
        } catch {
            print(error)
        }
        setUser(withName: user.getName()) { (isSuccess) in
            if isSuccess {
                completion?(true)
            }
            completion?(false)
        }
    }
    
    func getUserData(forUser name: String) -> UserModel? {
        guard let storedData = Locksmith.loadDataForUserAccount(userAccount: StorageKeys.oneTimePasswordAccount.rawValue) else { return nil }
        guard let dataList = storedData[StorageKeys.userName.rawValue] as? [Data] else { return nil }
        let userData = dataList.filter { (data) -> Bool in
            if let model = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UserModel.self, from: data) {
                if model.getName() == name {
                    return true
                }
                return false
            }
            return false
        }.first
        let userModel = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UserModel.self, from: userData!)
        return userModel
    }
}
