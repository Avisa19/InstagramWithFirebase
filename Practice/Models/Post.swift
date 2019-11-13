//
//  Post.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    
    var id: String?
    let user: User
    let imageUrl: String
    let caption: String
    let creationDate: Date
    
    var hasLiked: Bool = false
    
    init(user: User, dictionary: [String: Any]) {
        
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        let secondsAgo = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsAgo)
    }
}
