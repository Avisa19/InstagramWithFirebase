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
    
//    let mainTabBarController = MainTabBarController()
 
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
        
        guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err {
                print("Failed to log in:", err)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            // to reset & refresh the tabBar page.
              let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController

            mainTabBarController?.setupViewControllers()
            
            print("user successfully logged in:", uid)
            self.dismiss(animated: true, completion: nil)
        }
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

