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
        
        setupNavigationItems()
        
        fetchPosts()
    }
    
    fileprivate func setupNavigationItems() {
        
//        let image = UIImageView(image: #imageLiteral(resourceName: "profile"))
//        navigationItem.titleView = image
        
     
        
    }
    
    var posts = [Post]()
    
     fileprivate func fetchPosts() {
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
           let ref = Database.database().reference().child("posts").child(uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictianaries = snapshot.value as? [String: Any] else { return }
                dictianaries.forEach { (key, value) in
                    
    //                print("key: \(key), value: \(value)")
                    guard let dictionary = value as?
                        [String: Any] else { return }
                    
                    let post = Post(dictionary: dictionary)
                    print(post.caption)
                    self.posts.append(post)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }) { (err) in
                print("Failed to fetch post:", err)
            }
            
        }
        
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        
        cell.post = posts[indexPath.item]
        
        return cell
    }

}
