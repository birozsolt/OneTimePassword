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
    var leftBarButtonItem: NavBarButton?
    var rightBarButtonItem: NavBarButton = NavBarButton()
    
    private lazy var userListView = UserListView()
    private lazy var viewModel = UserListViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setNavigationAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = userListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
    }
    
    func setNavigationAppearance() {
        navBarTitle = LocalizationKeys.userList.rawValue.localized
        leftBarButtonItem = NavBarButton(withType: .back)
        rightBarButtonItem = NavBarButton(withType: .settings)
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
            print(viewModel.numberOfRows())
            cell.configure(withText: viewModel.userName(forIndex: indexPath.row),
                           separatorVisible: indexPath.row == viewModel.numberOfRows() - 1 ? false : true)
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
