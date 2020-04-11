//
//  UserListTableView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class UserListView: UIView {
    
    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: UserListTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        return tableView
    }()

    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.getColor(.background)
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(tableView)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
