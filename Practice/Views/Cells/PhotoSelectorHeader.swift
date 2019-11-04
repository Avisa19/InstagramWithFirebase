//
//  PhotoSelectorHeader.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 1/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    let photoHeader: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoHeader)
        photoHeader.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
