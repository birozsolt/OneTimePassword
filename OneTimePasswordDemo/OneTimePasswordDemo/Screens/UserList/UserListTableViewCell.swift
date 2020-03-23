//
//  UserListTableViewCell.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    static let identifier = "UserListTableViewCellIdentifier"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = AssetCatalog.getColor(.text)
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = AssetCatalog.getColor(.buttonBg)
        return view
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
        addSubview(nameLabel)
        addSubview(separatorLine)
        setupLayout()
    }
    
    private func setupLayout() {
        nameLabel.autoCenterInSuperview()
        
        separatorLine.autoPinEdge(toSuperviewEdge: .bottom)
        separatorLine.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        separatorLine.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        separatorLine.autoSetDimension(.height, toSize: 0.5)
    }
    
    func configure(withText text: String, separatorVisible: Bool) {
        nameLabel.text = text
        separatorLine.isHidden = !separatorVisible
    }
}
