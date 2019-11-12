//
//  Comment.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 12/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import Foundation

struct Comment {
    
    let text: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
