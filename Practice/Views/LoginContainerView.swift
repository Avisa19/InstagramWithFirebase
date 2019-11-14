//
//  LoginContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 31/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

protocol LoginContainerViewDelegate {
    func didHandleLogin()
    func didHandleEditChanged()
    func didHandleShowSignup()
}

class LoginContainerView: UIView {
    
    var delegate: LoginContainerViewDelegate?
    
    let logoView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.4705882353, blue: 0.8039215686, alpha: 1)
        return view
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.gray])
        attributedText.append(NSAttributedString(string: " Sign Up.", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .heavy), .foregroundColor: #colorLiteral(red: 0, green: 0.4705882353, blue: 0.8039215686, alpha: 1)]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        textField.textColor = .gray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.addTarget(self, action: #selector(handleEditChanged), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        textField.textColor = .gray
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.addTarget(self, action: #selector(handleEditChanged), for: .editingChanged)
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(signupButton)
        signupButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: self.frame.width, height: 38))
        
        addSubview(logoView)
        logoView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: self.frame.width, height: 150))
        
        let arrangedViews = [emailTextField, passwordTextField, loginButton]
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        addSubview(stackView)
        stackView.anchor(top: logoView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 40, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 158))
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handleLogin() {
        delegate?.didHandleLogin()
    }
    
    @objc fileprivate func handleEditChanged() {
        delegate?.didHandleEditChanged()
    }
    
    @objc fileprivate func handleShowSignup() {
        delegate?.didHandleShowSignup()
    }
    
}
