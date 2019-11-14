//
//  CameraController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 5/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

extension CameraController: AVCapturePhotoCaptureDelegate {
    
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)
        
        let previewImage = UIImage(data: imageData!)
    
        
        view.addSubview(previewContainerView)
        previewContainerView.fillSuperview()
       
        previewContainerView.previewPhotoImageView.image = previewImage
        
        print("Finish processing photo sample buffer...")
        
    }
    
}

class CameraController: UIViewController {
    
    lazy var cameraView: CameraContainerView = {
        let view = CameraContainerView()
        view.delegate = self
        return view
    }()
    
    lazy var previewContainerView: PreviewPhotoContainerView = {
        let view = PreviewPhotoContainerView()
        view.delegate = self
        return view
    }()
    
    let customAnimationPresentor = CustomAnimationPresentor()
    
    let customAnimationDismisser = CustomAnimationDismisser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCapturingPhoto()
        
        view.addSubview(cameraView)
        
        cameraView.fillSuperview()
        
        transitioningDelegate = self
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
 
    
     let output = AVCapturePhotoOutput()
    
    fileprivate func setupCapturingPhoto() {
        
        let captureSession = AVCaptureSession()
        
        //1. inputs
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
        } catch let inputErr {
            print("Failed to capture device input:", inputErr)
        }
        
        
        //2. outputs
        
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        //3. previews
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
   
}


extension CameraController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customAnimationPresentor
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return customAnimationDismisser
    }
    
   
}


extension CameraController: CameraContainerViewDelegate {
    func didHandleCapturing() {
           
             let settings = AVCapturePhotoSettings()
             
             #if (!arch(x86_64))
             guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
             
             settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
             
             output.capturePhoto(with: settings, delegate: self)
             #endif
    }
    
    func didHandleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension CameraController: PreviewPhotoContainerViewDelegate {
    func didHandleSavePhoto() {
        
        print("Attempting to save Photo...")
        
        guard let previewImage = previewContainerView.previewPhotoImageView.image else { return }
        
        let library = PHPhotoLibrary.shared()
        
        library.performChanges({
            
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
            
        }) { (success, err) in
            if let err = err {
                print("Failed to save photos:", err)
                return
            }
            print("Successfully saved image to library.")
            DispatchQueue.main.async {
                self.previewContainerView.setupSavedLabel()
            }
        }
    }
    
    func didHandleCancel() {
        previewContainerView.removeFromSuperview()
    }
    
    
}
