//
//  SearchCell.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 3/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            
            guard let user = user else { return }
            
            let imageUrl = user.profileImageUrl
            
            profileImageView.loadImage(urlString: imageUrl)
            
            usernameLabel.text = user.username
            
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemRed
        iv.layer.cornerRadius = 44 / 2
        return iv
    }()
    
    let usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "Avisa Lover"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0), size: .init(width: 44, height: 44))
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 58))
        
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
