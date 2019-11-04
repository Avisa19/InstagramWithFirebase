//
//  SearchController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 1/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

private let cellId = "Cell"

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let searchView = SearchContainerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        
        setupSearchBarInNavBar()
        
        searchView.searchBar.delegate = self
        
        fetchUsers()
    }
    
    var users = [User]()
    
    var filteredUsers = [User]()
    
    fileprivate func fetchUsers() {
        
        let ref = Database.database().reference().child("users")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach { (key, value) in
                
                guard let userDictionay = value as? [String: Any] else { return }
                let user = User(uid: key, dictionary: userDictionay)
                
                self.users.append(user)
                
            }
            
            self.users.sort { (u1, u2) -> Bool in
                return u1.username.compare(u2.username) == .orderedAscending
            }
            self.filteredUsers = self.users
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to fetch users:", err)
        }
    }
    
    fileprivate func setupSearchBarInNavBar() {
        navigationController?.navigationBar.addSubview(searchView.searchBar)
               searchView.searchBar.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        
        cell.user = filteredUsers[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
