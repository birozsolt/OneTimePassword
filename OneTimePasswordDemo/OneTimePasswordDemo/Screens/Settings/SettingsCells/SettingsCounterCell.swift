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

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        titleLabel.leadingAnchor(equalTo: contentView.leadingAnchor, constant: UIConstants.edgeInset)
            .centerVertical(equalTo: contentView.centerYAnchor)

        counterTextField.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -UIConstants.edgeInset)
            .centerVertical(equalTo: contentView.centerYAnchor)
            .heightAnchor(constant: UIConstants.buttonHeight)
            .widthAnchor(constant: UIConstants.buttonWidth / 2)

        separatorLine.leadingAnchor(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .heightAnchor(constant: UIConstants.separatorHeight)
    }
}
