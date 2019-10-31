//
//  MainTabBarController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let navController = UINavigationController(rootViewController: userProfileController)
        navController.tabBarItem.image = #imageLiteral(resourceName: "user")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "user")
        
        viewControllers = [navController, UIViewController()]
    }
    

  

}


