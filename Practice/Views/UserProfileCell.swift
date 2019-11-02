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
            
            guard let imageUrl = post?.imageUrl else { return }
            guard let url = URL(string: imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                if let err = err {
                    print("Failed to fetch ImageData:", err)
                    return
                }
                
                guard let dataImage = data else { return }
                guard let imagePost = UIImage(data: dataImage) else { return }

                DispatchQueue.main.async {
                    self.postImages.image = imagePost
                }
            }.resume()
        }
    }
    
    let postImages: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
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
