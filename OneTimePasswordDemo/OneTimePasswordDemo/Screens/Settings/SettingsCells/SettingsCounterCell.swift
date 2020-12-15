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
        label.textColor = AssetCatalog.color(.text)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var counterTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AssetCatalog.color(.background)
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.textAlignment = .right
        textField.textColor = AssetCatalog.color(.text)
        textField.tintColor = AssetCatalog.color(.buttonBg)
        var counterArray = [1, 2, 3, 4, 5]
        textField.loadDropdownData(from: counterArray.map { String($0) },
                                   defaultValue: LocalStorage.getStringValue(forKey: .numberOfInput))
        return textField
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = AssetCatalog.color(.buttonBg)
        return view
    }()
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }
    
    // MARK: - Public methods
    
    func configure(withText text: String, separatorVisible: Bool = true) {
        titleLabel.text = text
        separatorLine.isHidden = !separatorVisible
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(counterTextField)
        contentView.addSubview(separatorLine)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.edgeInset),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            counterTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.edgeInset),
            counterTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            counterTextField.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight),
            counterTextField.widthAnchor.constraint(equalToConstant: UIConstants.buttonWidth / 2),
            
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: UIConstants.separatorHeight)
        ])
    }
}
