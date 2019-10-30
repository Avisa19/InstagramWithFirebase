//
//  SignupContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 30/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SignupContainerView: UIView {
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 1, alpha: 1)
        button.layer.cornerRadius = 140 / 2
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 1, alpha: 1)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 1, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(plusPhotoButton)
        
        let arrangedViews = [emailTextField, usernameTextField, passwordTextField, signupButton]
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 140),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 140),
            plusPhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusPhotoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 212)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



