//
//  UserProfileHeader.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase


class UserProfileHeader: UICollectionViewCell {
    
    lazy var headerView: UserProfileHeaderContainerView = {
       let view = UserProfileHeaderContainerView()
        view.delegateForCell = self
        return view
    }()
    
    var user: User? {
        didSet {
            
            guard let imageURL = user?.profileImageUrl else { return }
            
            headerView.profileImageView.loadImage(urlString: imageURL)
            
            headerView.usernameLabel.text = user?.username
            
            setupFollowAndEditButton()
        }
    }
    
    
    
    fileprivate func setupFollowAndEditButton() {
        
        guard let currentUserLoggedInId = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        currentUserLoggedInId == userId ? setupEditProfileStats(userId, currentUserLoggedInId) : setupFollowButtonStats(userId, currentUserLoggedInId)
        
    }
    
    fileprivate func setupFollowButtonStats(_ userId: String, _ currentUser: String) {
        // check is following
        Database.database().reference().child("following").child(currentUser).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            //            print(snapshot.value as Any)
            
            if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                
                self.setupUnfollowButton()
                
            } else {
                
                self.setupFollowButton()
            }
            
        }) { (err) in
            print("Failed to check the following:", err)
        }
        
    }
    
    fileprivate func setupUnfollowButton() {
        self.headerView.editProfileFollowButton.setTitle("UnFollow", for: .normal)
        
        self.headerView.editProfileFollowButton.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.8117647059, blue: 1, alpha: 1)
        
        self.headerView.editProfileFollowButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        
        self.headerView.editProfileFollowButton.setTitleColor(.white, for: .normal)
    }
    
    fileprivate func setupFollowButton() {
        self.headerView.editProfileFollowButton.setTitle("Follow", for: .normal)
        self.headerView.editProfileFollowButton.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.6039215686, blue: 0.9294117647, alpha: 1)
        self.headerView.editProfileFollowButton.setTitleColor(.white, for: .normal)
        self.headerView.editProfileFollowButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    }
    
    fileprivate func setupEditProfileStats(_ userId: String, _ currentUser: String) {
        
        headerView.editProfileFollowButton.setTitle("Edit Profile", for: .normal)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerView)
        headerView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserProfileHeader: UserProfileHeaderForCellDelegate {
    func didHandleEditAndFollow() {
        
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        let ref = Database.database().reference().child("following").child(currentUser)
        
        if headerView.editProfileFollowButton.titleLabel?.text == "UnFollow" {
            // unFollow
            ref.removeValue { (err, ref) in
                if let err = err {
                    print("Failed to unFollow:", err)
                    return
                    }
                    
                    print("Successfully unFollowed user.", self.user?.username ?? "")
                    
                    self.setupFollowButton()
                }
                
                
             } else {
                // following
                
                let values: [String: Any] = [userId: 1]
                
                ref.updateChildValues(values) { (err, ref) in
                    
                    if let err = err {
                        print("Failed to create following user group:", err)
                        return
                    }
                    
                    print("following users successfully saved to DB.")
                    self.setupUnfollowButton()
                }
        }
    }
}
