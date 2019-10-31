//
//  LoginContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

class LoginContainerView: UIView {
    
       let signupButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Don't have an account? Sign Up.", for: .normal)
//            let attributedText = NSMutableAttributedString(string: "Don't have an account?", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor(white: 0, alpha: 0.1)])
//            attributedText.append(NSAttributedString(string: " Sign Up.", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .heavy), .foregroundColor: UIColor.blue]))
//            button.titleLabel?.attributedText = attributedText
        button.addTarget(self, action: #selector(LoginController.handleShowSignup), for: .touchUpInside)
            return button
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(signupButton)
        signupButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: self.frame.width, height: 38))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
