//
//  UserListViewCell.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

class UserListViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        avatarLoadingTask?.cancel()
        avatarLoadingTask = nil
    }
    
    func fill(user: UserViewModel) {
        avatarImageView.image = nil
        nicknameLabel.text = user.nickname
        
        if let avatarURL = user.avatarURL {
            avatarLoadingTask = ImageLoader.shared.loadImage(url: avatarURL) { [weak self] image in
                self?.avatarImageView.image = image
            }
        }
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nicknameLabel: UILabel!
    
    private var avatarLoadingTask: URLSessionTask?
}
