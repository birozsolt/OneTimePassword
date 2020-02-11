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
        return label
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
        setupLayout()
    }
    
    private func setupLayout() {
        nameLabel.autoCenterInSuperview()
    }
    
    func configure(withText text: String) {
        nameLabel.text = text
    }
}
