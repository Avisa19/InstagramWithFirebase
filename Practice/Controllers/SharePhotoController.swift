//
//  SharePhotoController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    let containerView = ShareContainerView()
    
    var selectedImage: UIImage? {
        didSet {
            containerView.shareImageView.image = selectedImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    fileprivate func setupImageAndTextViews() {
        
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: CGSize(width: 0, height: 100))
    }
    
    // Hidden Status Bar

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc fileprivate func handleShare() {
        print("Continue sharing...")
    }


}
