//
//  SecureStorage.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 13/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import SwiftKeychainWrapper
import Foundation

private enum SecureStorageKeys: String {
    case userName
    case userList
}

final class SecureStorage {
    
    // MARK: - Properties
    
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    private static let keychainWrapper = KeychainWrapper.standard
    
    typealias SecureStoreCallBack = (Bool) -> Void
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public methods
    
    static func deleteAllData() {
        keychainWrapper.removeAllKeys()
    }
    
    static func getUser(forName name: String) -> String? {
        return keychainWrapper.string(forKey: SecureStorageKeys.userName.rawValue)
    }
    
    static func getUserList() -> [String] {
        guard let userList = keychainWrapper.data(forKey: SecureStorageKeys.userList.rawValue),
              let list = try? decoder.decode([String].self, from: userList) else {
            return []
        }
        return list
    }
    
    static func saveUserData(forUser user: UserModel, completion: SecureStoreCallBack?) {
        do {
            let jsonDataToSave = try encoder.encode(user)
            guard keychainWrapper.set(jsonDataToSave, forKey: user.name) == true else {
                completion?(false)
                return
            }
            saveUserList(addingName: user.name) { (isSuccess) in
                completion?(isSuccess)
            }
        } catch {
            completion?(false)
        }
    }
    
    static func getUserData(forUser name: String) -> UserModel? {
        guard let userData = keychainWrapper.data(forKey: name) else {
            return nil
        }
        let model = try? decoder.decode(UserModel.self, from: userData)
        return model
    }
    
    // MARK: - Private methods

    private static func saveUserList(addingName name: String, completion: SecureStoreCallBack?) {
        guard let data = keychainWrapper.data(forKey: SecureStorageKeys.userList.rawValue) else {
            guard let jsonDataToSave = try? encoder.encode([name]),
                  keychainWrapper.set(jsonDataToSave, forKey: SecureStorageKeys.userList.rawValue) == true else {
                completion?(false)
                return
            }
            completion?(true)
            return
        }
        guard var list = try? decoder.decode([String].self, from: data), !list.contains(name) else {
            completion?(false)
            return
        }
        list.append(name)
        guard let jsonDataToSave = try? encoder.encode(list),
              keychainWrapper.set(jsonDataToSave, forKey: SecureStorageKeys.userList.rawValue) == true else {
            completion?(false)
            return
        }
        completion?(true)
    }
}
