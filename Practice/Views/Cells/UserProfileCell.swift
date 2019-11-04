//
//  UserProfileCell.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

class UserProfileCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
//            print(1)
            guard let imageUrl = post?.imageUrl else { return }
            postImages.loadImage(urlString: imageUrl)
        }
    }
 
    
    let postImages: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImages)
        postImages.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
