//
//  LoginController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
 
    let loginView = LoginContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginView)
        loginView.fillSuperview()
    }

    @objc func handleShowSignup() {
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
    }
}
