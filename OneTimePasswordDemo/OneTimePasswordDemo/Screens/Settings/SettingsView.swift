//
//  SettingsView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class SettingsView: UIView {
    
    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.register(SettingsBasicCell.self, forCellReuseIdentifier: SettingsBasicCell.identifier)
        tableView.register(SettingsCounterCell.self, forCellReuseIdentifier: SettingsCounterCell.identifier)
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
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
