//
//  UserDetailsAPIWorker.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

protocol UserDetailsAPIWorkerProtocol {
    func loadUserDetails(user: UserEntity, completion: @escaping (Result<UserEntity, Swift.Error>) -> Void)
}

class UserDetailsAPIWorker: BaseAPIWorker {
}

extension UserDetailsAPIWorker: UserDetailsAPIWorkerProtocol {
    
    func loadUserDetails(user: UserEntity, completion: @escaping (Result<UserEntity, Swift.Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(user.nickname)")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let result = self.processDataTaskCompletion(data: data, response: response, error: error) { data -> UserEntity in
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(UserEntity.self, from: data)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
