//
//  UserListTableView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 10/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class UserListView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: UserListTableViewCell.identifier)
        tableView.separatorColor = AssetCatalog.getColor(.buttonBg)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        return tableView
    }()

    override func layoutSubviews() {
        backgroundColor = AssetCatalog.getColor(.background)
        setupView()
    }
    
    private func setupView() {
        addSubview(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        tableView.autoPinEdgesToSuperviewSafeArea()
    }
}
