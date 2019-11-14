//
//  CommentController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 10/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase



class CommentController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var post: Post?
    
    var comments = [Comment]()
    
    let commentCellId = "CellcommentId"
    
    lazy var containerView: InputAccessoryContainerView = {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let cView = InputAccessoryContainerView(frame: frame)
        cView.delegate = self
        return cView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView.backgroundColor = .white
        
        // accessory input view has 50, that's why we choose -50
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentCellId)
        
           fetchComment()

        
    }
    
    // when you create a page through pushVC , we should activate our function through lifeCycle of changing the page like viewWillAppear, Disappear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func fetchComment() {
        print("Attemoting to fetch comments...")
        guard let postId = post?.id else { return }
        
        let ref = Database.database().reference().child("comments").child(postId)
        ref.observe(.childAdded, with: { (snapshot) in
        print(snapshot.value as Any)
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            Database.fetchUserWithUid(uid: uid) { (user) in
                
                let comment = Comment(user: user, dictionary: dictionary)
                self.comments.append(comment)
                self.collectionView.reloadData()
            }
            
        }) { (err) in
            print("Failed to fetch comments")
        }
        
    }


    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
           let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
             let dummyCell = CommentCell(frame: frame)
             dummyCell.comment = comments[indexPath.item]
             dummyCell.layoutIfNeeded()
             
             let targetSize = CGSize(width: view.frame.width, height: 1000)
             let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
             
             let height = max(40 + 8 + 8, estimatedSize.height)
             return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellId, for: indexPath) as! CommentCell
        
        cell.comment = comments[indexPath.item]
        
        
        return cell
    }
    
    // For write something like textField
    // It's activate when you define cView outside and call it in this closure, UIView should be global not just limited and trapped in ⬇️
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}

// trying to create bridge
extension CommentController: CommentInputAccessoryViewDelegate {
    
    func didSubmit(for comment: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        print("post id:", self.post?.id ?? "")
        
        print("Inserting comment:", comment)
        
        
        guard let postId = post?.id else { return }
        
        let values: [String: Any] = ["text": comment, "creationDate": Date().timeIntervalSince1970, "uid": uid]
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
            
            if let err = err {
                print("Failed to insert comment:", err)
                return
            }
            
            print("Successfully inserted comment.")
            self.containerView.clearCommentTextField()
        }
        
    }
    
    
}
