//
//  SearchContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 3/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            filteredUsers = users
            collectionView.reloadData()
            return
        }
        filteredUsers = self.users.filter { (user) -> Bool in
            return user.username.lowercased().contains(searchText.lowercased())
        }
        
        self.collectionView.reloadData()
    }
}

class SearchContainerView: UIView {
    
    let searchBar: UISearchBar = {
       let sb = UISearchBar()
        sb.placeholder = "Enter username"
        return sb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
