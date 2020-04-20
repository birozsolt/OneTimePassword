//
//  SettingsViewModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class SettingsViewModel: NSObject {
    
	// MARK: - Init
	
    override init() {
        super.init()
    }
    
	// MARK: - Public methods
	
    func numberOfRows() -> Int {
        return 3
    }
}
