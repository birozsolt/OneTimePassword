//
//  SettingsViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class SettingsViewModel {
    
	// MARK: - Public methods
    
    func saveSwitchValue(_ value: Bool, forKey key: LocalStorageKeys) {
        LocalStorage.saveValue(value, forKey: key)
    }
    
    func numberOfRows() -> Int {
        3
    }
}
