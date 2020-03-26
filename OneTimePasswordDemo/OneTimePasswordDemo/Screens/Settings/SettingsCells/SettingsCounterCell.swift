//
//  SettingsCounterCell.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 26/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class SettingsCounterCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsCounterCellIdentifier"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = AssetCatalog.getColor(.text)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var counterTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AssetCatalog.getColor(.background)
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.textAlignment = .right
        textField.textColor = AssetCatalog.getColor(.text)
        textField.tintColor = AssetCatalog.getColor(.buttonBg)
        textField.loadDropdownData(from: ["2", "3", "4", "5", "6"],
                                   defaultValue: LocalStorage.shared.getValue(forKey: .numberOfInput) as? String ?? "")
        return textField
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = AssetCatalog.getColor(.buttonBg)
        return view
    }()
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }
    
    // MARK: - Public methods
    
    func configure(withText text: String, separatorVisible: Bool) {
        titleLabel.text = text
        separatorLine.isHidden = !separatorVisible
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(counterTextField)
        addSubview(separatorLine)
        setupLayout()
    }
    
    private func setupLayout() {
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        counterTextField.autoAlignAxis(toSuperviewAxis: .horizontal)
        counterTextField.autoSetDimensions(to: CGSize(width: 100, height: 50))
        counterTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        separatorLine.autoPinEdge(toSuperviewEdge: .bottom)
        separatorLine.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        separatorLine.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        separatorLine.autoSetDimension(.height, toSize: 0.5)
    }
}
