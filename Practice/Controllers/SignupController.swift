//
//  SignupController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 30/10/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UIViewController {
    
    let signupView = SignupContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    fileprivate func setupViews() {
        
         view.addSubview(signupView)
         signupView.fillSuperview()
     }

    @objc func handleSignup() {
        
        guard let email = signupView.emailTextField.text, let password = signupView.passwordTextField.text, let username = signupView.usernameTextField.text else { return }
        guard email.count > 0, password.count > 0, username.count > 0 else { return }
       // first Authenticate user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            if let err = err {
                print("Failed to create user", err)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            guard let image = self.signupView.plusPhotoButton.imageView?.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let fileName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("profile_Image").child(fileName)
            
            // take image and save it as a Data to firebase Storage
            storageRef.putData(uploadData, metadata: nil) { (metaData, err) in
                
                if let err = err {
                    print("Failed to upload image:", err)
                    return
                }
                // download image Url from storage to save it to DB.
                storageRef.downloadURL { (url, err) in
                    if let err = err {
                        print("Failed to uplaod URL String", err)
                        return
                    }
                    guard let profileImageUrl = url?.absoluteString else { return }
                    
                    let usernameValues = ["username": username, "profileImageUrl": profileImageUrl]
                    
                    let dictionaryValues = [uid: usernameValues]
                    
                 // Start saving to DB
                    Database.database().reference().child("users").updateChildValues(dictionaryValues) { (err, red) in
                        if let err = err {
                            print("Failed to save to DB:", err)
                            return
                        }
                        
                        print("Successfully saved to Db.")
                    }
                }
                
            }

        }
    }
    
    @objc func handleInputTextChanged() {
        
        let isInputsValid = signupView.emailTextField.text?.count ?? 0 > 0 && signupView.passwordTextField.text?.count ?? 0 > 0 && signupView.usernameTextField.text?.count ?? 0 > 0
        
        if isInputsValid {
            
            signupView.signupButton.isEnabled = true
            signupView.signupButton.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.5254901961, blue: 0.9294117647, alpha: 1)
            
        } else {
            signupView.signupButton.isEnabled = false
            signupView.signupButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }

}

extension SignupController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handlePlusPhoto() {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            
            signupView.plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            
            signupView.plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        signupView.plusPhotoButton.layer.cornerRadius = signupView.plusPhotoButton.frame.width / 2
        signupView.plusPhotoButton.clipsToBounds = true
        signupView.plusPhotoButton.layer.borderColor = UIColor.gray.cgColor
        signupView.plusPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
}
