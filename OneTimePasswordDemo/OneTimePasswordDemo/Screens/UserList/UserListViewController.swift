//
//  UserListViewController.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 11/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class UserListViewController: BaseViewController, NavigationBarProtocol {
    var navBarTitle: String?
    var leftBarButtonItem: UIBarButtonItem?
    
    private lazy var userListView = UserListView()
    private lazy var viewModel = UserListViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navBarTitle = LocalizationKeys.userList.rawValue.localized
        leftBarButtonItem = UIBarButtonItem(title: LocalizationKeys.back.rawValue.localized, style: .plain, target: self, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier) as? UserListTableViewCell {
            cell.configure(withText: viewModel.userName(forIndex: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseVC = VerificationViewController(userName: self.viewModel.userName(forIndex: indexPath.row),
                                                viewType: .test)
        self.navigationController?.pushViewController(baseVC, animated: true)
    }
}
