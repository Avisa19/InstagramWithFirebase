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
        commentTextView.text = nil
        commentTextView.showPlaceHolderLabel()
    }
    // It's really help you to find the bug , because you make it fileprivate... very very important.
    fileprivate let commentTextView: CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
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
        
        autoresizingMask = .flexibleHeight
        
        backgroundColor = .white
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        addSubview(submitButton)
        submitButton.anchor(top: topAnchor, leading: commentTextView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8), size: .init(width: 50, height: 50))
        
        
        setupLineSeperatorView()
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
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
        
        guard let commentText = commentTextView.text else { return }
        
        delegate?.didSubmit(for: commentText)
    }
    
}
