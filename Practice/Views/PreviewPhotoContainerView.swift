//
//  PreviewPhotoContainerView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 9/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class PreviewPhotoContainerView: UIView {
    
    let previewPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(CameraController.handleCancel), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "save").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(CameraController.handleSavePhoto), for: .touchUpInside)
        return button
    }()
    
    let savedLabel: UILabel = {
       let label = UILabel()
        label.text = "Saved Successfully"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.backgroundColor = UIColor(white: 0, alpha: 0.3)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewPhotoImageView)
        previewPhotoImageView.fillSuperview()
        
        addSubview(cancelButton)
        cancelButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 80, height: 80))
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 12, bottom: 12, right: 0), size: .init(width: 80, height: 80))
    }
    
    func setupSavedLabel() {
        self.addSubview(savedLabel)
        savedLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        savedLabel.center = self.center
        savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
            
        }) { (completed) in
            //completed
            UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                self.savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                
            }) { (_) in
                
                self.savedLabel.removeFromSuperview()
                self.savedLabel.alpha = 0
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
