//
//  CommentCell.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 11/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet {
            
            guard let imageUrl = comment?.user.profileImageUrl else { return }
            
            profileImageView.loadImage(urlString: imageUrl)
            
            setupAtrributedCommentLabelText()
            
        }
    }
    
    fileprivate func setupAtrributedCommentLabelText() {
        
        guard let username = comment?.user.username, let commentText = comment?.text else { return }
        
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "  \(commentText)", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .light)]))
        
        commentTextView.attributedText = attributedText
    }
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let profileImageView: CustomImageView = {
       let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 42 / 2
        return imageView
    }()
    
    let dividerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 4, left: 4, bottom: 4, right: 0), size: .init(width: 42, height: 42))
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 4, right: 4))
        addSubview(dividerView)
        dividerView.anchor(top: commentTextView.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: commentTextView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
