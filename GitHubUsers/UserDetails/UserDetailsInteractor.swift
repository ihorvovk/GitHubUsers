//
//  UserDetailsInteractor.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

protocol UserDetailsInteractorProtocol {
    func showUser()
    func loadUserDetails()
}

class UserDetailsInteractor {
    
    init(user: UserEntity, presenter: UserDetailsPresenterProtocol, apiWorker: UserDetailsAPIWorkerProtocol) {
        self.user = user
        self.presenter = presenter
        self.apiWorker = apiWorker
    }
    
    // MARK: - Private
    
    private let user: UserEntity
    private let presenter: UserDetailsPresenterProtocol
    private let apiWorker: UserDetailsAPIWorkerProtocol
}

extension UserDetailsInteractor: UserDetailsInteractorProtocol {

    func showUser() {
        presenter.present(user: user)
    }
    
    func loadUserDetails() {
        apiWorker.loadUserDetails(user: user) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let user):
                self.presenter.present(user: user)
            case .failure(let error):
                self.presenter.present(error: error)
            }
        }
    }
}
