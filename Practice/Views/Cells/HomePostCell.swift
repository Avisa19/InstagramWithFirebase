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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(homePostView)
        homePostView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
