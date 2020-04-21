//
//  SettingsViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var settingsView = SettingsView()
    private lazy var viewModel = SettingsViewModel()
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.tableView.delegate = self
        settingsView.tableView.dataSource = self
    }
    
    // MARK: - Private methods
    
	func setNavigationAppearance() {
		navBarTitle = LocalizationKeys.settings.rawValue.localized
        leftBarButtonItem = NavBarButton(withType: .back)
	}
}

// MARK: - UITableViewDataSource methods

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsBasicCell.identifier) as? SettingsBasicCell else {
                return UITableViewCell()
            }
            cell.configure(withText: LocalizationKeys.secureInput.rawValue.localized, forKey: .secureInput)
            cell.setupOnOffSwitchAction { [weak cell] _ in
				guard let cell = cell else { return }
                if cell.switchIsOn() {
                    cell.setSwitch(toValue: true, forKey: .secureInput)
                } else {
                    cell.setSwitch(toValue: false, forKey: .secureInput)
                }
            }
            return cell
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsBasicCell.identifier) as? SettingsBasicCell else {
                return UITableViewCell()
            }
            cell.configure(withText: LocalizationKeys.helperLines.rawValue.localized, forKey: .helperLines)
            cell.setupOnOffSwitchAction { [weak cell] _ in
				guard let cell = cell else { return }
                if cell.switchIsOn() {
                    cell.setSwitch(toValue: true, forKey: .helperLines)
                } else {
                    cell.setSwitch(toValue: false, forKey: .helperLines)
                }
            }
            return cell
        }
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCounterCell.identifier) as? SettingsCounterCell else {
                return UITableViewCell()
            }
            cell.configure(withText: LocalizationKeys.numberOfInput.rawValue.localized, separatorVisible: false)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate methods

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
