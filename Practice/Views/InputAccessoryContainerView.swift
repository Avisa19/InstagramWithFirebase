//
//  InputAccessoryContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 11/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}
class InputAccessoryContainerView: UIView {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    func clearCommentTextField() {
        textField.text = nil
    }
    // It's really help you to find the bug , because you make it fileprivate... very very important.
   fileprivate let textField: UITextField = {
        let tx = UITextField()
        tx.placeholder = "Type in some comments"
        tx.isUserInteractionEnabled = true
        return tx
    }()
    
   fileprivate let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(textField)
        textField.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        addSubview(submitButton)
        submitButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8))
        
        
        setupLineSeperatorView()
    }
    
    fileprivate func setupLineSeperatorView() {
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        addSubview(dividerView)
        dividerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func submit() {
        
        guard let commentText = textField.text else { return }
        
        delegate?.didSubmit(for: commentText)
    }
    
}
