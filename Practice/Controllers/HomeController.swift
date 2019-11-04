//
//  HomeController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 1/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase


private let cellId = "Cell"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.alwaysBounceVertical = true
        
        setupNavigationItems()
        
        fetchPosts()
    }
    
    fileprivate func setupNavigationItems() {
        navigationController?.navigationBar.isTranslucent = false
        //        let image = UIImageView(image: #imageLiteral(resourceName: "profile"))
        //        navigationItem.titleView = image
        
        
        
    }
    
    var posts = [Post]()
    
    fileprivate func fetchPosts() {
        
          guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUid(uid: uid) { (user) in
            self.fetchPostsWithUser(user)
        }
        
    }
    
    fileprivate func fetchPostsWithUser(_ user: User) {
        
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictianaries = snapshot.value as? [String: Any] else { return }
            dictianaries.forEach { (key, value) in
                
                guard let postDictionary = value as? [String: Any] else { return }
                
                let post = Post(user: user, dictionary: postDictionary)
                
                self.posts.append(post)
            }
            
                 self.collectionView.reloadData()
            
        }) { (err) in
            print("failed to fetch user:", err)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        
        cell.post = posts[indexPath.item]
        
        return cell
    }

}
