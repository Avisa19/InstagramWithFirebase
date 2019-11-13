//
//  HomePostCell.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

protocol HomePostCellDelegate {
    func didTapComment(post: Post)
    func didLike(cell: HomePostCell)
}

class HomePostCell: UICollectionViewCell {
    
      var delegate: HomePostCellDelegate?
     
     var post: Post? {
         didSet {
             
              likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "icons8-like").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "hearts").withRenderingMode(.alwaysOriginal), for: .normal)
             guard let imageUrl = post?.imageUrl else { return }
             photoImageView.loadImage(urlString: imageUrl)
             
             usernameLabel.text = post?.user.username
             
             guard let imageProfileUrl = post?.user.profileImageUrl else { return }
             
             userProfileImageView.loadImage(urlString: imageProfileUrl)
             
             captionLabel.text = post?.caption
             
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
         
         captionLabel.attributedText = attributedText
     }
     
     
     
     let userProfileImageView: CustomImageView = {
         let imageView = CustomImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.layer.cornerRadius = 40 / 2
         return imageView
     }()
     
     let photoImageView: CustomImageView = {
         let imageView = CustomImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
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
     
     lazy var likeButton: UIButton = {
         let button = UIButton(type: .system)
         button.setImage(#imageLiteral(resourceName: "hearts").withRenderingMode(.alwaysOriginal), for: .normal)
         button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
         return button
     }()
     
     lazy var commentButton: UIButton = {
         let button = UIButton(type: .system)
         button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
         button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
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
     
     let seperatorDivider: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor(white: 0, alpha: 0.3)
         return view
     }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         backgroundColor = .white
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
         captionLabel.anchor(top: stackViews.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
         
         addSubview(seperatorDivider)
         seperatorDivider.anchor(top: captionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 0.5))
         
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     @objc func handleComment() {
         // Activate the protocol
         guard let post = post else { return }
         delegate?.didTapComment(post: post)
     }
     
     @objc func handleLike() {
         
        delegate?.didLike(cell: self)
         
     }
     
}
