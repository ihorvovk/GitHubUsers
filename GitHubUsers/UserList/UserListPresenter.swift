//
//  UserListPresenter.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

protocol UserListPresenterProtocol {
    func present(users: [UserEntity])
    func present(nextUsers: [UserEntity])
    func present(error: Error)
    func update(isLoading: Bool)
}

struct UserViewModel {
    let nickname: String
    let avatarURL: URL?
}

class UserListPresenter {
    
    init(viewController: UserListViewControllerProtocol) {
        self.viewController = viewController
    }

    // MARK: - Private
    
    private weak var viewController: UserListViewControllerProtocol?
}

extension UserListPresenter: UserListPresenterProtocol {
    
    func present(users: [UserEntity]) {
        let viewModels = users.map { UserViewModel(nickname: $0.nickname, avatarURL: $0.avatarURL) }
        viewController?.set(users: viewModels)
    }
    
    func present(nextUsers: [UserEntity]) {
        let viewModels = nextUsers.map { UserViewModel(nickname: $0.nickname, avatarURL: $0.avatarURL) }
        viewController?.append(users: viewModels)
    }
    
    func present(error: Error) {
        viewController?.set(error: error)
    }
    
    func update(isLoading: Bool) {
        viewController?.set(isLoading: isLoading)
    }
}
