//
//  MainTabBarController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
    }
    
     func setupViewControllers() {
          let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
          let navController = UINavigationController(rootViewController: userProfileController)
          navController.tabBarItem.image = #imageLiteral(resourceName: "user")
          navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "user")
          
          viewControllers = [navController, UIViewController()]
      }
  

}


