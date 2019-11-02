//
//  SharePhotoController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

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
        
        let filename = NSUUID().uuidString
        
        guard let image = selectedImage else { return }
        guard let uploadedData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let refStorage = Storage.storage().reference().child("posts").child(filename)
        refStorage.putData(uploadedData, metadata: nil) { (metaData, err) in
            if let err = err {
                print("Failed to store share image:", err)
                return
            }
            
            refStorage.downloadURL { (url, err) in
                if let err = err {
                    print("Failed to download imageUrl:", err)
                    return
                }
               guard let imageUrl = url?.absoluteString
                else { return }
                 print("Successfully store share image:", imageUrl)
                
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
            }
        }
        
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        
        guard let postImage = selectedImage else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        guard let caption = containerView.commentTextView.text, caption.count > 0 else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userPostsRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostsRef.childByAutoId()
        let values: [String: Any] = ["imageUrl": imageUrl, "caption": caption, "imageHeight": postImage.size.height, "imageWidth": postImage.size.width, "creationDate:": Date().timeIntervalSince1970]
        
        ref.updateChildValues(values) { (err, ref) in
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            if let err = err {
                print("Failed to save posts to DB:", err)
                return
            }
            
            print("Successfully saved to DB.")
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }


}
