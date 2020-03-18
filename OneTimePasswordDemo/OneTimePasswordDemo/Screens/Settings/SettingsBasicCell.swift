//
//  SettingsBasicCell.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class SettingsBasicCell: UITableViewCell {
    static let identifier = "SettingsBasicCellIdentifier"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var onOffSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.thumbTintColor = .white
        cellSwitch.onTintColor = .darkGray
        return cellSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(onOffSwitch)
        setupLayout()
    }
    
    private func setupLayout() {
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        onOffSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        onOffSwitch.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func onSwitchIsOn() -> Bool {
        return onOffSwitch.isOn
    }
    
    func setSwitch(toValue value: Bool) {
//        onOffSwitch.setOn(value, animated: true)
        LocalStorage.shared.saveValue(value, forKey: LocalStorageKeys.secureInput)
    }
    
    func configure(withText text: String) {
        titleLabel.text = text
        onOffSwitch.isOn = LocalStorage.shared.getValue(forKey: LocalStorageKeys.secureInput) as? Bool ?? false
    }
    
    func setupOnOffSwitchAction(closure: @escaping UIControl.UIControlTargetClosure) {
        onOffSwitch.addAction(for: .touchUpInside, closure: closure)
    }
}
