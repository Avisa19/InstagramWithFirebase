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

         navigationController?.isNavigationBarHidden = true
        view.addSubview(loginView)
        loginView.fillSuperview()
    }

    @objc func handleShowSignup() {
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    @objc func handleLogin() {
        print("Login...")
    }
    
    @objc func handleEditChanged() {
        
        let isInputsValid = loginView.emailTextField.text?.count ?? 0 > 0 && loginView.passwordTextField.text?.count ?? 0 > 0
              
              if isInputsValid {
                  
                loginView.loginButton.isEnabled = true
                loginView.loginButton.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.5254901961, blue: 0.9294117647, alpha: 1)
                  
              } else {
                
                loginView.loginButton.isEnabled = false
                loginView.loginButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

