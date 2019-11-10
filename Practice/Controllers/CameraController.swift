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
    
    @objc func handleCapturing() {
        
        let settings = AVCapturePhotoSettings()
        
        #if (!arch(x86_64))
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
        
        output.capturePhoto(with: settings, delegate: self)
        #endif
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)
        
        let previewImage = UIImage(data: imageData!)
    
        
        view.addSubview(previewContainerView)
        previewContainerView.fillSuperview()
       
        previewContainerView.previewPhotoImageView.image = previewImage
        
        print("Finish processing photo sample buffer...")
        
    }
    
    @objc func handleSavePhoto() {
    
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
    
    @objc func handleCancel() {
        
        previewContainerView.removeFromSuperview()
    }
}

class CameraController: UIViewController {
    
    let cameraView = CameraContainerView()
    
    let previewContainerView = PreviewPhotoContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCapturingPhoto()
        
        view.addSubview(cameraView)
        
        cameraView.fillSuperview()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @objc func handleDismiss() {
        
        dismiss(animated: true, completion: nil)
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
