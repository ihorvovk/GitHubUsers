//
//  UserListAPIWorker.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

protocol UserListAPIWorkerProtocol {
    func loadUsers(sinceUser: UserEntity?, completion: @escaping (Result<[UserEntity], Swift.Error>) -> Void)
}

class UserListAPIWorker: BaseAPIWorker {
}

extension UserListAPIWorker: UserListAPIWorkerProtocol {
    
    func loadUsers(sinceUser: UserEntity?, completion: @escaping (Result<[UserEntity], Swift.Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.github.com/users")!
        if let sinceUser = sinceUser {
            urlComponents.queryItems = [URLQueryItem(name: "since", value: "\(sinceUser.id)")]
        }
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let result = self.processDataTaskCompletion(data: data, response: response, error: error) { data -> [UserEntity] in
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode([UserEntity].self, from: data)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
