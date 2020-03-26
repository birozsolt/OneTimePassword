//
//  UITextfieldExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 26/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

extension UITextField {
    /// Present drop down list
    func loadDropdownData(from data: [String], defaultValue: String = "") {
        self.inputView = OTPDropDownPickerView(pickerData: data, dropdownField: self, defaultValue: defaultValue)
    }
}
