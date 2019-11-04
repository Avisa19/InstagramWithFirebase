//
//  SearchCell.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 3/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    let searchCellView = SearchCellView()
    
    var user: User? {
        didSet {
            
            guard let user = user else { return }
            
            let imageUrl = user.profileImageUrl
            
                searchCellView.profileImageView.loadImage(urlString: imageUrl)
            
                searchCellView.usernameLabel.text = user.username
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(searchCellView)
        searchCellView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
