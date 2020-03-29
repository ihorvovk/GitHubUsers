//
//  UserDetailsBuilder.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

class UserDetailsBuilder {
    
    class func buildScene(viewController: UserDetailsViewController, user: UserEntity) {
        let apiWorker = UserDetailsAPIWorker()
        let presenter = UserDetailsPresenter(viewController: viewController)
        let interactor = UserDetailsInteractor(user: user, presenter: presenter, apiWorker: apiWorker)
        
        viewController.setUp(interactor: interactor)
    }
}
