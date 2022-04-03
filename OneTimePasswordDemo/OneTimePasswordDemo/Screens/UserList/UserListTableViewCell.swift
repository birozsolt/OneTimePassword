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
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = AssetCatalog.color(.text)
        return label
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

        nameLabel.centerHorizontal(equalTo: safeAreaLayoutGuide.centerXAnchor)
            .centerVertical(equalTo: safeAreaLayoutGuide.centerYAnchor)

        separatorLine.leadingAnchor(equalTo: contentView.leadingAnchor, constant: UIConstants.separatorPadding)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -UIConstants.separatorPadding)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .heightAnchor(constant: UIConstants.separatorHeight)
    }
}
