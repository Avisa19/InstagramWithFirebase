//
//  CommentController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 10/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class CommentController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView.backgroundColor = .systemBlue

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    let containerView: InputAccessoryContainerView = {
        let cView = InputAccessoryContainerView()
        cView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        return cView
    }()
    
    // For write something like textField
    // It's activate when you define cView outside and call it in this closure, UIView should be global not just limited and trapped in ⬇️
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}
