//
//  CustomTabbarController.swift
//  fbMessenger
//
//  Created by Paing Aung on 4/27/18.
//  Copyright © 2018 Paing Aung. All rights reserved.
//

import UIKit

class CustomTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendController = FriendsController(collectionViewLayout: layout)
        let recentMessageNavController = UINavigationController(rootViewController: friendController)
        recentMessageNavController.tabBarItem.title = "Recent"
        recentMessageNavController.tabBarItem.image = UIImage(named: "recent")
        
        viewControllers = [recentMessageNavController, createDummyNavControllerWithTitle(title: "Calls", imageName: "calls"), createDummyNavControllerWithTitle(title: "People", imageName: "people"), createDummyNavControllerWithTitle(title: "Settings", imageName: "settings")]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
