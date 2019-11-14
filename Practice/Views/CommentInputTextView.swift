//
//  CommentInputTextView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 14/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class CommentInputTextView: UITextView {
    
    fileprivate let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter comment"
        label.textColor = .lightGray
        return label
    }()
    
    func showPlaceHolderLabel() {
        placeHolderLabel.isHidden = false
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideLabel), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handleHideLabel() {
        placeHolderLabel.isHidden = !self.text.isEmpty
    }
    

}
