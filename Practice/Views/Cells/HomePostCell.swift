//
//  HomePostCell.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    let homePostView = HomePostView()
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else { return }
            homePostView.photoImageView.loadImage(urlString: imageUrl)
            
                homePostView.usernameLabel.text = post?.user.username
            
            guard let imageProfileUrl = post?.user.profileImageUrl else { return }
            
            homePostView.userProfileImageView.loadImage(urlString: imageProfileUrl)
            
                homePostView.captionLabel.text = post?.caption
            
            setupAttributedCaption()
            
        }
    }
    
    fileprivate func setupAttributedCaption() {
        
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 4, weight: .regular)]))
        
         let timeAgoDisplay = post.creationDate.timeAgoDisplay()
        attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: UIColor.systemGray]))
        
        homePostView.captionLabel.attributedText = attributedText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(homePostView)
        homePostView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
