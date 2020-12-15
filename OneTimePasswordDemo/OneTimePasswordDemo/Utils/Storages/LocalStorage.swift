//
//  LocalStorage.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 18/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

enum LocalStorageKeys: String {
    case secureInput
    case helperLines
    case numberOfInput
}

final class LocalStorage {
    
    // MARK: - Properties
    
    private static let defaults = UserDefaults.standard
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public methods
    
    static func saveValue(_ value: Any, forKey key: LocalStorageKeys) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    static func getBoolValue(forKey key: LocalStorageKeys) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
    
    static func getStringValue(forKey key: LocalStorageKeys) -> String {
        return defaults.string(forKey: key.rawValue) ?? ""
    }
    
    static func getIntValue(forKey key: LocalStorageKeys) -> Int {
        return defaults.integer(forKey: key.rawValue)
    }
}
