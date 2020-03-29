//
//  UserListViewController.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

protocol UserListViewControllerProtocol: class {
    func set(users: [UserViewModel])
    func append(users: [UserViewModel])
    func set(error: Error)
    func set(isLoading: Bool)
}

class UserListViewController: UIViewController {

    func setUp(interactor: UserListInteractorProtocol, router: UserListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetails", let userIndex = tableView.indexPathForSelectedRow?.row {
            router.routeToUserDetails(userIndex: userIndex, segue: segue)
        }
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noUsersLabel: UILabel!
    
    private var interactor: UserListInteractorProtocol!
    private var router: UserListRouterProtocol!
    private var users: [UserViewModel] = []
    
    func updateNoUsersLabel() {
        if let footerView = tableView.tableFooterView, !footerView.isHidden || users.count > 0 {
            noUsersLabel.isHidden = true
        } else {
            noUsersLabel.isHidden = false
        }
    }
}

extension UserListViewController: UserListViewControllerProtocol {
    
    func set(users: [UserViewModel]) {
        self.users = users
        tableView.reloadData()
        updateNoUsersLabel()
    }
    
    func append(users: [UserViewModel]) {
        self.users.append(contentsOf: users)
        let indexPathsToInsert = (self.users.count - users.count ... self.users.count - 1).map { IndexPath(row: $0, section: 0) }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsToInsert, with: .automatic)
        tableView.endUpdates()
    }
    
    func set(error: Error) {
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func set(isLoading: Bool) {
        tableView.tableFooterView?.isHidden = !isLoading
        updateNoUsersLabel()
    }
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as? UserListViewCell else {
            return UITableViewCell()
        }
        
        cell.fill(user: users[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > users.count - 10 {
            interactor.loadNextUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
