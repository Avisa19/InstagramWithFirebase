//
//  Comment.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 12/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import Foundation

struct Comment {
    
    // comments always belong to user, so it's not make sense to be optional, we should initialized it.
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
