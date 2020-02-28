//
//  StringExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 28/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
