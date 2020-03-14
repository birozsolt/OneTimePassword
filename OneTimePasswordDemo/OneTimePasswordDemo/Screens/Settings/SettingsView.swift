//
//  SettingsView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class SettingsView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.register(SettingsBasicCell.self, forCellReuseIdentifier: SettingsBasicCell.identifier)
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func layoutSubviews() {
        backgroundColor = .lightGray
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
