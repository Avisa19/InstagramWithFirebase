//
//  UserProfileHeaderContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 4/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

protocol UserProfileHeaderDelegate {
    func didChangetoListView()
    func didChangeToGridView()
}

class UserProfileHeaderContainerView: UIView {
    
    var delegate: UserProfileHeaderDelegate?
    
     let profileImageView: CustomImageView = {
           let imageView = CustomImageView()
            imageView.backgroundColor = .gray
            imageView.layer.cornerRadius = 84 / 2
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        lazy var gridButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
             button.tintColor = UIColor(white: 0, alpha: 0.2)
            button.addTarget(self, action: #selector(handleChangeToGridView), for: .touchUpInside)
            return button
        }()
        
        let bookmarkButton: UIButton = {
              let button = UIButton(type: .system)
              button.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
            button.tintColor = UIColor(white: 0, alpha: 0.2)
              return button
          }()
        
        lazy var listButton: UIButton = {
              let button = UIButton(type: .system)
              button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
             button.tintColor = UIColor(white: 0, alpha: 0.08)
            button.addTarget(self, action: #selector(handleChangeToListView), for: .touchUpInside)
              return button
          }()
        
        let usernameLabel: UILabel = {
           let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            return label
        }()

        let seperatorLine: UIView = {
           let view = UIView()
            view.backgroundColor = .darkGray
            return view
        }()
        
        let postLabel: UILabel = {
            let label = UILabel()
            label.text = "14\nPosts"
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        let followersLabel: UILabel = {
            let label = UILabel()
            label.text = "19\nFollowers"
            label.textAlignment = .center
             label.numberOfLines = 0
            return label
        }()
        
        let followingsLabel: UILabel = {
            let label = UILabel()
            label.text = "24\nFollowing"
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        let editProfileFollowButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Edit Profile", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            return button
        }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
            backgroundColor = .white
            addSubview(profileImageView)
            profileImageView.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 84, height: 84))
            
            addSubview(usernameLabel)
            usernameLabel.anchor(top: profileImageView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 12, bottom: 0, right: 0))
            
            setupBottomToolbar()
            setupStatusBar()
        }
        
        fileprivate func setupStatusBar() {
            
            let arrangedViews = [postLabel, followersLabel, followingsLabel]
            let stackView = UIStackView(arrangedSubviews: arrangedViews)
            addSubview(stackView)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 50))
            addSubview(editProfileFollowButton)
            editProfileFollowButton.anchor(top: stackView.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 38))
        }
        
        fileprivate func setupBottomToolbar() {
            let arrangedViews = [gridButton, listButton, bookmarkButton]
            let stackView = UIStackView(arrangedSubviews: arrangedViews)
            addSubview(stackView)
            stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: self.frame.width, height: 50))
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            
            addSubview(seperatorLine)
            seperatorLine.anchor(top: nil, leading: leadingAnchor, bottom: stackView.topAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: self.frame.width, height: 0.5))
            
            addSubview(dividerLine)
            dividerLine.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: frame.width, height: 0.5))
            
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleChangeToListView() {
        print("See in the list view ...")
        listButton.tintColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.8235294118, alpha: 1)
        gridButton.tintColor = UIColor(white: 0, alpha: 0.2)
        delegate?.didChangetoListView()
    }
    
    @objc func handleChangeToGridView() {
        print("See in the grid view ...")
        gridButton.tintColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.8235294118, alpha: 1)
        listButton.tintColor = UIColor(white: 0, alpha: 0.2)
        delegate?.didChangeToGridView()
    }
    
}

