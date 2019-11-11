//
//  InputAccessoryContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 11/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class InputAccessoryContainerView: UIView {
    
    let textField: UITextField = {
        let tx = UITextField()
        tx.placeholder = "Type in some comments"
        tx.isUserInteractionEnabled = true
        return tx
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(textField)
        textField.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        addSubview(submitButton)
        submitButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8))
        
    }
    
    @objc func handleSend() {
        print("sending some data...")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
