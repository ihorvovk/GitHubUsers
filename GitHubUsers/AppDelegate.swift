//
//  AppDelegate.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 28.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let navigationVC = window?.rootViewController as? UINavigationController, let userListVC = navigationVC.topViewController as? UserListViewController {
            UserListBuilder.buildScene(viewController: userListVC)
        }
        
        return true
    }
}

