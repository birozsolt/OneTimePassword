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
    case numberOfInput
}

final class LocalStorage: NSObject {
    
    // MARK: - Properties
    
    static let shared = LocalStorage()
    private let defaults: UserDefaults
    
    // MARK: - Init
    
    private override init() {
        defaults = .standard
        super.init()
    }
    
    // MARK: - Public methods
    
    func saveValue(_ value: Any, forKey key: LocalStorageKeys) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    func getValue(forKey key: LocalStorageKeys) -> AnyObject {
        return defaults.object(forKey: key.rawValue) as AnyObject
    }
}
