//
//  OTPDropDownPickerView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 26/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class OTPDropDownPickerView: UIPickerView {
    
    // MARK: - Properties
    
    private let pickerData: [String]
    private let pickerTextField: UITextField
    
    // MARK: - Init
    
    init(pickerData: [String], dropdownField: UITextField, defaultValue: String = "") {
        // Init properties
        self.pickerData = pickerData
        pickerTextField = dropdownField
        // Super init
        super.init(frame: .zero)
        backgroundColor = AssetCatalog.color(.textfieldBg)
        // Set delegates
        delegate = self
        dataSource = self
        setupToolBar()
        DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
            if !pickerData.isEmpty {
                if !defaultValue.isEmpty, pickerData.contains(defaultValue) {
                    self.pickerTextField.text = defaultValue
                } else {
                    self.pickerTextField.text = pickerData[0]
                }
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupToolBar() {
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.isTranslucent = true
        toolBar.tintColor = AssetCatalog.color(.text)
        toolBar.backgroundColor = AssetCatalog.color(.textfieldBg)
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        pickerTextField.inputAccessoryView = toolBar
    }
    
    @objc private func donePicker (sender: UIBarButtonItem) {
        LocalStorage.saveValue(pickerData[selectedRow(inComponent: 0)], forKey: .numberOfInput)
        pickerTextField.resignFirstResponder()
    }
}

// MARK: - UIPickerViewDataSource methods

extension OTPDropDownPickerView: UIPickerViewDataSource {
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
}

// MARK: - UIPickerViewDelegate methods

extension OTPDropDownPickerView: UIPickerViewDelegate {
    // This function sets the text of the picker view to the content of the "pickerData" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[row]
    }
    // When user selects an option, this function will set the text of the text field to reflect the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
}
