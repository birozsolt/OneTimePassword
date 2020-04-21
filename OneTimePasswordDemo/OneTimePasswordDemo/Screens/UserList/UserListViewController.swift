//
//  UserListViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class UserListViewController: BaseViewController {
    
    // MARK: - Properties

    private lazy var userListView = UserListView()
    private lazy var viewModel = UserListViewModel()
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        view = userListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
    }
    
    // MARK: - Private methods
    
	func setNavigationAppearance() {
        navBarTitle = LocalizationKeys.userList.rawValue.localized
        leftBarButtonItem = NavBarButton(withType: .back)
        rightBarButtonItems.append(NavBarButton(withType: .settings))
    }
}

// MARK: - UITableViewDataSource methods

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier) as? UserListTableViewCell {
            cell.configure(withText: viewModel.userName(forIndex: indexPath.row),
                           separatorVisible: indexPath.row == viewModel.numberOfRows() - 1 ? false : true)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate methods

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseVC = VerificationViewController(userName: self.viewModel.userName(forIndex: indexPath.row),
                                                viewType: .test)
        self.navigationController?.pushViewController(baseVC, animated: true)
    }
}
