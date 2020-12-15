//
//  UserListTableViewCell.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class UserListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "UserListTableViewCellIdentifier"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = AssetCatalog.color(.text)
        return label
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
    
    func configure(withText text: String, separatorVisible: Bool) {
        nameLabel.text = text
        separatorLine.isHidden = !separatorVisible
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(separatorLine)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        contentView.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: UIConstants.separatorHeight)
        ])
    }
}
