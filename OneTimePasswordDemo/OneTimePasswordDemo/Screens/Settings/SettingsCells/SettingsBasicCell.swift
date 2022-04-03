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
        
        titleLabel.leadingAnchor(equalTo: contentView.leadingAnchor, constant: UIConstants.edgeInset)
            .centerVertical(equalTo: contentView.centerYAnchor)

        onOffSwitch.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -UIConstants.edgeInset)
            .centerVertical(equalTo: contentView.centerYAnchor)

        separatorLine.leadingAnchor(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .heightAnchor(constant: UIConstants.separatorHeight)
    }
}
