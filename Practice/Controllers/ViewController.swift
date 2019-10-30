//
//  ViewController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 30/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let signupView = SignupContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signupView)
        signupView.fillSuperview()
        
    }
}

