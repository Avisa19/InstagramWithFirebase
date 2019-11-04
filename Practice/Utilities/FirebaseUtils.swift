//
//  FirebaseUtils.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 3/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    static func fetchUserWithUid(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
            
        }) { (err) in
            print("Failed to fetch post:", err)
        }
        
    }
}
