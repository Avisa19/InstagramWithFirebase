//
//  MainTabBarController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoselectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
}

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
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
        
        // Home
        let navHome = templateNavController(selectedImage: #imageLiteral(resourceName: "home"), unSelectedImage: #imageLiteral(resourceName: "home"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Search
        let navSearch = templateNavController(selectedImage: #imageLiteral(resourceName: "search"), unSelectedImage: #imageLiteral(resourceName: "search"), rootViewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()))

        // Plus
        let navPlus = templateNavController(selectedImage: #imageLiteral(resourceName: "plus"), unSelectedImage: #imageLiteral(resourceName: "plus"), rootViewController: UIViewController())
        
        // Heart
        let navHeart = templateNavController(selectedImage: #imageLiteral(resourceName: "hearts"), unSelectedImage: #imageLiteral(resourceName: "hearts"), rootViewController: HeartController())
        
        // user profile
        let navProfile = templateNavController(selectedImage: #imageLiteral(resourceName: "user"), unSelectedImage: #imageLiteral(resourceName: "user"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
          
          viewControllers = [navHome,
                             navSearch,
                             navPlus,
                             navHeart,
                             navProfile]
        
        // modify tabBar items
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
      }
  
    func templateNavController(selectedImage: UIImage, unSelectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = selectedImage.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = unSelectedImage
        
        return navController
    }
 

}



