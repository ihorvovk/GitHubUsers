//
//  UserListRouter.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

protocol UserListRouterProtocol {
    func routeToUserDetails(userIndex: Int, segue: UIStoryboardSegue)
}

class UserListRouter {
    
    init(dataStore: UserListDataStore) {
        self.dataStore = dataStore
    }
    
    // MARK: - Private
    
    private let dataStore: UserListDataStore
}

extension UserListRouter: UserListRouterProtocol {
    
    func routeToUserDetails(userIndex: Int, segue: UIStoryboardSegue) {
        guard let userDetailsVC = segue.destination as? UserDetailsViewController, userIndex < dataStore.users.count else {
            return
        }
        
        UserDetailsBuilder.buildScene(viewController: userDetailsVC, user: dataStore.users[userIndex])
    }
}
