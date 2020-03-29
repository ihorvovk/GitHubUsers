//
//  UserListBuilder.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

class UserListBuilder {
    
    class func buildScene(viewController: UserListViewController) {
        let apiWorker = UserListAPIWorker()
        let presenter = UserListPresenter(viewController: viewController)
        let interactor = UserListInteractor(presenter: presenter, apiWorker: apiWorker)
        let router = UserListRouter(dataStore: interactor)
        
        viewController.setUp(interactor: interactor, router: router)
    }
}
