//
//  UserDetailsPresenter.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    func present(user: UserEntity)
    func present(error: Error)
}

struct UserDetailsViewModel {
    let nickname: String
    let avatarURL: URL?
    var numberOfFollowers: String?
    var numberOfPublicRepos: String?
}

class UserDetailsPresenter {
    
    init(viewController: UserDetailsViewControllerProtocol) {
        self.viewController = viewController
    }

    // MARK: - Private
    
    private weak var viewController: UserDetailsViewControllerProtocol?
}

extension UserDetailsPresenter: UserDetailsPresenterProtocol {
    
    func present(user: UserEntity) {
        var viewModel = UserDetailsViewModel(nickname: user.nickname, avatarURL: user.avatarURL, numberOfFollowers: nil, numberOfPublicRepos: nil)
        if let numberOfFollowers = user.numberOfFollowers {
            viewModel.numberOfFollowers = "\(numberOfFollowers)"
        }
        
        if let numberOfPublicRepos = user.numberOfPublicRepos {
            viewModel.numberOfPublicRepos = "\(numberOfPublicRepos)"
        }
        
        viewController?.set(viewModel: viewModel)
    }
    
    func present(error: Error) {
        self.viewController?.set(error: error)
    }
}
