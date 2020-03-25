//
//  SettingsViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, NavigationBarProtocol {
    
    // MARK: - Properties
    
    var navBarTitle: String?
    var leftBarButtonItem: NavBarButton?
    
    private lazy var settingsView = SettingsView()
    private lazy var viewModel = SettingsViewModel()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setNavigationAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setNavigationAppearance()
    }
    
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
    
    private func setNavigationAppearance() {
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingsBasicCell.identifier) as? SettingsBasicCell {
            cell.configure(withText: LocalizationKeys.secureInput.rawValue.localized,
                           separatorVisible: indexPath.row == viewModel.numberOfRows() - 1 ? false : true)
            cell.setupOnOffSwitchAction { _ in
                if cell.switchIsOn() {
                    cell.setSwitch(toValue: true)
                } else {
                    cell.setSwitch(toValue: false)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate methods

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
