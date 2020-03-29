//
//  UserListInteractor.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

protocol UserListInteractorProtocol {
    func loadUsers()
    func loadNextUsers()
}

protocol UserListDataStore {
    var users: [UserEntity] { get }
}

class UserListInteractor: UserListDataStore {
    
    private(set) var users: [UserEntity] = []
    
    init(presenter: UserListPresenterProtocol, apiWorker: UserListAPIWorkerProtocol) {
        self.presenter = presenter
        self.apiWorker = apiWorker
    }
    
    // MARK: - Private
    
    private let presenter: UserListPresenterProtocol
    private let apiWorker: UserListAPIWorkerProtocol
    
    private var nextPageSinceUser: UserEntity?
    private var isLoadingUsers = false {
        didSet {
            presenter.update(isLoading: isLoadingUsers)
        }
    }
}

extension UserListInteractor: UserListInteractorProtocol {
    
    func loadUsers() {
        if isLoadingUsers {
            return
        }
        
        isLoadingUsers = true
        apiWorker.loadUsers(sinceUser: nil) { [weak self] result in
            guard let `self` = self else { return }
            self.isLoadingUsers = false
            
            switch result {
            case .success(let users):
                self.users = users
                self.presenter.present(users: users)
                self.nextPageSinceUser = users.last
            case .failure(let error):
                self.presenter.present(error: error)
            }
        }
    }
    
    func loadNextUsers() {
        if isLoadingUsers || nextPageSinceUser == nil {
            return
        }
        
        isLoadingUsers = true
        apiWorker.loadUsers(sinceUser: nextPageSinceUser) { [weak self] result in
            guard let `self` = self else { return }
            self.isLoadingUsers = false
            
            switch result {
            case .success(let users):
                self.users.append(contentsOf: users)
                self.presenter.present(nextUsers: users)
                self.nextPageSinceUser = users.last
            case .failure(let error):
                self.presenter.present(error: error)
            }
        }
    }
}
