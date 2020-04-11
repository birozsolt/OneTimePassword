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
        label.textColor = AssetCatalog.getColor(.text)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var onOffSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.thumbTintColor = AssetCatalog.getColor(.buttonBg)
        cellSwitch.onTintColor = AssetCatalog.getColor(.textfieldBg)
        return cellSwitch
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
    
    func switchIsOn() -> Bool {
        return onOffSwitch.isOn
    }
    
    func setSwitch(toValue value: Bool, forKey key: LocalStorageKeys) {
        LocalStorage.shared.saveValue(value, forKey: key)
    }
    
    func configure(withText text: String, separatorVisible: Bool = true, forKey key: LocalStorageKeys) {
        titleLabel.text = text
        onOffSwitch.isOn = LocalStorage.shared.getValue(forKey: key) as? Bool ?? false
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
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            onOffSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            onOffSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: UIConstants.separatorHeight)
        ])
    }
}
