//
//  HomePostView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 4/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class HomePostView: UIView {

     let userProfileImageView: CustomImageView = {
           let imageView = CustomImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.backgroundColor = .systemBlue
           imageView.layer.cornerRadius = 40 / 2
           return imageView
       }()
       
       let photoImageView: CustomImageView = {
          let imageView = CustomImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.backgroundColor = .systemGray
           return imageView
       }()
       
       let usernameLabel: UILabel = {
           let label = UILabel()
           label.text = "Avisa Lover"
           label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
           return label
       }()
       
       let optionsButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("•••", for: .normal)
           button.setTitleColor(.black, for: .normal)
           return button
       }()
       
       let likeButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "hearts").withRenderingMode(.alwaysOriginal), for: .normal)
           return button
       }()
       
       let commentButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
           return button
       }()
       
       let sentButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "send").withRenderingMode(.alwaysOriginal), for: .normal)
           return button
       }()
       
       let bookmarkButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "bookmark").withRenderingMode(.alwaysOriginal), for: .normal)
           return button
       }()
       
       
       let captionLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           return label
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           backgroundColor = UIColor(white: 0, alpha: 0.1)
           addSubview(photoImageView)
           addSubview(userProfileImageView)
           addSubview(usernameLabel)
           addSubview(optionsButton)
           
           userProfileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 40, height: 40))
           
           usernameLabel.anchor(top: topAnchor, leading: userProfileImageView.trailingAnchor, bottom: photoImageView.topAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 4))
           
           optionsButton.anchor(top: topAnchor, leading: usernameLabel.trailingAnchor, bottom: photoImageView.topAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8), size: .init(width: 48, height: 48))
           
           photoImageView.anchor(top: userProfileImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
           photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
           
           let arrangedViews = [likeButton, commentButton, sentButton]
           let stackViews = UIStackView(arrangedSubviews: arrangedViews)
           addSubview(stackViews)
           
           stackViews.distribution = .fillEqually

           stackViews.anchor(top: photoImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 4, right: 0), size: .init(width: 120, height: 50))
           
           addSubview(bookmarkButton)
           bookmarkButton.anchor(top: photoImageView.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8), size: .init(width: 50, height: 50))
           
           addSubview(captionLabel)
           captionLabel.anchor(top: stackViews.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
   }



