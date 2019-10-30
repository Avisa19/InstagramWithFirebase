//
//  SignupController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 30/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UIViewController {
    
    let signupView = SignupContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    fileprivate func setupViews() {
        
         view.addSubview(signupView)
         signupView.fillSuperview()
     }

    @objc func handleSignup() {
        
        guard let email = signupView.emailTextField.text, let password = signupView.passwordTextField.text, let username = signupView.usernameTextField.text else { return }
        guard email.count > 0, password.count > 0, username.count > 0 else { return }
       
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            if let err = err {
                print("Failed to create user", err)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            print("Successfully create user", uid)
        }
    }
    
    @objc func handleInputTextChanged() {
        
        let isInputsValid = signupView.emailTextField.text?.count ?? 0 > 0 && signupView.passwordTextField.text?.count ?? 0 > 0 && signupView.usernameTextField.text?.count ?? 0 > 0
        
        if isInputsValid {
            
            signupView.signupButton.isEnabled = true
            signupView.signupButton.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.5254901961, blue: 0.9294117647, alpha: 1)
            
        } else {
            signupView.signupButton.isEnabled = false
            signupView.signupButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }

}
