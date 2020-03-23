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
}

final class LocalStorage: NSObject {
    static let shared = LocalStorage()
    private let defaults: UserDefaults
    
    private override init() {
        defaults = .standard
    }
    
    func saveValue(_ value: Any, forKey key: LocalStorageKeys) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    func getValue(forKey key: LocalStorageKeys) -> AnyObject {
        return defaults.object(forKey: key.rawValue) as AnyObject
    }
}
