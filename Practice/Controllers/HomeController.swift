//
//  HomeController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 1/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase


private let homeCellId = "HomeCell"


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotification()

        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: homeCellId)
        
        collectionView.alwaysBounceVertical = true
        
        setupNavigationItems()
        
        fetchAllPosts()
        
        setupRefresherControll()
    }
    
    fileprivate func fetchAllPosts() {
//          fetchPosts()
          
          fetchFollowingUserUid()
      }
    
    func setupNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.newsFeedNotification, object: nil)
       }
    
    @objc func handleUpdateFeed() {
        handleRefresh()
    }
    
    fileprivate func setupRefresherControll() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    @objc fileprivate func handleRefresh() {
        
        posts.removeAll()
        fetchAllPosts()
        collectionView.reloadData()
    }
    
    fileprivate func setupNavigationItems() {
        
        navigationController?.navigationBar.isTranslucent = false
       
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "instagram").withRenderingMode(.alwaysOriginal))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camers").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
        
    }
    
    @objc fileprivate func handleCamera() {
        
        let cameraController = CameraController()
        
        present(cameraController, animated: true, completion: nil)
    }
    
    
    var posts = [Post]()
    
    fileprivate func fetchFollowingUserUid() {
       
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDic = snapshot.value as? [String: Any] else { return }
            
            userDic.forEach { (key, value) in
                
                Database.fetchUserWithUid(uid: key) { (user) in
                    self.fetchPostsWithUser(user)
                    
                    self.collectionView.reloadData()
                }
            }
            
        }) { (err) in
            print("Failed to fetch uid's:", err)
        }
    }
    
    fileprivate func fetchPosts() {
        
          guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUid(uid: uid) { (user) in
            
            self.fetchPostsWithUser(user)
        }
        
    }
    
    fileprivate func fetchPostsWithUser(_ user: User) {
        
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            self.collectionView.refreshControl?.endRefreshing()
            
            guard let dictianaries = snapshot.value as? [String: Any] else { return }
            dictianaries.forEach { (key, value) in
                
                guard let postDictionary = value as? [String: Any] else { return }
                
                var post = Post(user: user, dictionary: postDictionary)
                
                //create connection between post and comment
                post.id = key
                
                //create a connection between posts and likes
                guard let uid = Auth.auth().currentUser?.uid else { return }
                Database.database().reference().child("likes").child(key).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let value = snapshot.value as? Int, value == 1 {
                        post.hasLiked = true
                    } else {
                        post.hasLiked = false
                    }
                    
                    self.posts.append(post)
                    self.posts.sort { (p1, p2) -> Bool in
                                   return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                               }
                    self.collectionView.reloadData()
                    
                }) { (err) in
                    print("Failed to fetch likes:", err)
                }
            }
        }) { (err) in
            print("failed to fetch user:", err)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        let dummyCell = HomePostCell(frame: frame)
//        dummyCell.homePostView.post = posts[indexPath.item]
//        dummyCell.layoutIfNeeded()
//        let targetSize = CGSize(width: view.frame.width, height: 1000)
//        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 50
        height += 60
//        let finalHeight = max(height, estimatedSize.height)
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! HomePostCell
      
        cell.post = posts[indexPath.item]
        
        cell.delegate = self
        
        return cell
    }
    
}

extension HomeController: HomePostCellDelegate {
  
    func didTapComment(post: Post) {
        
        let commentController = CommentController(collectionViewLayout: UICollectionViewFlowLayout())
        
        commentController.post = post
        navigationController?.pushViewController(commentController, animated: true)
        
        
        print(post.caption)
        
    }
    
    func didLike(cell: HomePostCell) {
        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post = self.posts[indexPath.item]
        print(post.caption)
        
        guard let postId = post.id else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [uid: post.hasLiked == true ? 0 : 1]
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
            
            if let err = err {
                print("Failed to like post:", err)
                return
            }
            
            print("Successfully liked post.")
            
            post.hasLiked = !post.hasLiked
            
            self.posts[indexPath.item] = post
            
            self.collectionView?.reloadItems(at: [indexPath])
            
        }
    }
    
}
