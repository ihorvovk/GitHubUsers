//
//  UserEntity.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

struct UserEntity: Decodable {
    
    let id: Int
    let nickname: String
    let avatarURL: URL?
    let numberOfFollowers: Int?
    let numberOfPublicRepos: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname = "login"
        case avatarURL = "avatar_url"
        case numberOfFollowers = "followers"
        case numberOfPublicRepos = "public_repos"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        nickname = try container.decode(String.self, forKey: .nickname)
        
        if let avatarURLString = try? container.decode(String.self, forKey: .avatarURL) {
            avatarURL = URL(string: avatarURLString)
        } else {
            avatarURL = nil
        }
        
        numberOfFollowers = try? container.decode(Int.self, forKey: .numberOfFollowers)
        numberOfPublicRepos = try? container.decode(Int.self, forKey: .numberOfPublicRepos)
    }
}
