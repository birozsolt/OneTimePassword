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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AssetCatalog.color(.background)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setupView() {
        addSubview(tableView)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        tableView.topAnchor(equalTo: safeAreaLayoutGuide.topAnchor)
            .leadingAnchor(equalTo: safeAreaLayoutGuide.leadingAnchor)
            .trailingAnchor(equalTo: safeAreaLayoutGuide.trailingAnchor)
            .bottomAnchor(equalTo: safeAreaLayoutGuide.bottomAnchor)
    }
}
