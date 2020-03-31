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
        addSubview(titleLabel)
        addSubview(onOffSwitch)
        addSubview(separatorLine)
        setupLayout()
    }
    
    private func setupLayout() {
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        onOffSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        onOffSwitch.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        separatorLine.autoPinEdge(toSuperviewEdge: .bottom)
        separatorLine.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        separatorLine.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        separatorLine.autoSetDimension(.height, toSize: 0.5)
    }
}
