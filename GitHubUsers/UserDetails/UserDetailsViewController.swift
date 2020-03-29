//
//  UserDetailsViewController.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

protocol UserDetailsViewControllerProtocol: class {
    func set(viewModel: UserDetailsViewModel)
    func set(error: Error)
}

class UserDetailsViewController: UIViewController {

    func setUp(interactor: UserDetailsInteractorProtocol) {
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.showUser()
        interactor.loadUserDetails()
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followersActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var repositoriesLabel: UILabel!
    @IBOutlet private weak var repositoriesActivityIndicator: UIActivityIndicatorView!
    
    private var interactor: UserDetailsInteractorProtocol!
}

extension UserDetailsViewController: UserDetailsViewControllerProtocol {
    
    func set(viewModel: UserDetailsViewModel) {
        if let avatarURL = viewModel.avatarURL {
            _ = ImageLoader.shared.loadImage(url: avatarURL) { [weak self] image in
                self?.avatarImageView.image = image
            }
        }
        
        nicknameLabel.text = viewModel.nickname
        
        followersLabel.text = viewModel.numberOfFollowers
        followersLabel.isHidden = (viewModel.numberOfFollowers == nil)
        followersActivityIndicator.isHidden = (viewModel.numberOfFollowers != nil)
        
        repositoriesLabel.text = viewModel.numberOfPublicRepos
        repositoriesLabel.isHidden = (viewModel.numberOfPublicRepos == nil)
        repositoriesActivityIndicator.isHidden = (viewModel.numberOfPublicRepos != nil)
    }
    
    func set(error: Error) {
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
