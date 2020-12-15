//
//  SettingsBasicCell.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class SettingsBasicCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsBasicCellIdentifier"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = AssetCatalog.color(.text)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var onOffSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.thumbTintColor = AssetCatalog.color(.buttonBg)
        cellSwitch.onTintColor = AssetCatalog.color(.textfieldBg)
        return cellSwitch
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
    
    func switchValue() -> Bool {
        return onOffSwitch.isOn
    }
    
    func configure(withText text: String, separatorVisible: Bool = true, forKey key: LocalStorageKeys) {
        titleLabel.text = text
        onOffSwitch.isOn = LocalStorage.getBoolValue(forKey: key)
        separatorLine.isHidden = !separatorVisible
    }
    
    func setupOnOffSwitchAction(closure: @escaping UIControl.UIControlTargetClosure) {
        onOffSwitch.addAction(for: .touchUpInside, closure: closure)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(onOffSwitch)
        contentView.addSubview(separatorLine)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.edgeInset),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            onOffSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.edgeInset),
            onOffSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: UIConstants.separatorHeight)
        ])
    }
}
