//
//  SecureStorage.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 13/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import SwiftKeychainWrapper
import Foundation

enum SecureStorageKeys: String {
    case userName
    case userList
    case oneTimePasswordAccount
}

final class SecureStorage {
    
    // MARK: - Properties
    
    static let shared = SecureStorage()
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let keychainWrapper = KeychainWrapper.standard
    
    typealias SecureStoreCallBack = (Bool) -> Void
    
    // MARK: - Init
    
    private init() {
    }
    
    // MARK: - Public methods
    
    func deleteAllData() {
        keychainWrapper.removeAllKeys()
    }
    func getUser(forName name: String) -> String? {
        return keychainWrapper.string(forKey: SecureStorageKeys.userName.rawValue)
    }
    
    func saveUserList(addingName name: String, completion: SecureStoreCallBack?) {
        guard let data = keychainWrapper.data(forKey: SecureStorageKeys.userList.rawValue) else {
            do {
                let jsonDataToSave = try encoder.encode([name])
                keychainWrapper.set(jsonDataToSave, forKey: SecureStorageKeys.userList.rawValue) == true ? completion?(true) : completion?(false)
            } catch {
                print(error)
                completion?(false)
            }
            return
        }
        do {
            var list = try decoder.decode([String].self, from: data)
            if !list.contains(name) {
                list.append(name)
                let jsonDataToSave = try encoder.encode(list)
                keychainWrapper.set(jsonDataToSave, forKey: SecureStorageKeys.userList.rawValue) == true ? completion?(true) : completion?(false)
            }
        } catch {
            print(error)
            completion?(false)
        }
    }
    
    func getUserList() -> [String] {
        guard let userList = keychainWrapper.data(forKey: SecureStorageKeys.userList.rawValue) else {
            return []
        }
        let list = try? decoder.decode([String].self, from: userList)
        return (list == nil ? [] : list)!
    }
    
    func saveUserData(forUser user: UserModel, completion: SecureStoreCallBack?) {
        do {
            let jsonDataToSave = try encoder.encode(user)
            if keychainWrapper.set(jsonDataToSave, forKey: user.name) == true {
                saveUserList(addingName: user.name) { (isSuccess) in
                    completion?(isSuccess)
                }
            } else {
                completion?(false)
            }
        } catch {
            completion?(false)
            print(error)
        }
    }
    
    func getUserData(forUser name: String) -> UserModel? {
        guard let userData = keychainWrapper.data(forKey: name) else {
            return nil
        }
        do {
            let model = try decoder.decode(UserModel.self, from: userData)
            return model
        } catch {
            print(error)
            return nil
        }
    }
}
