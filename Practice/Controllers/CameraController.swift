//
//  CameraController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 5/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import AVFoundation

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
        
        
        let previewImageView = UIImageView(image: previewImage)
        view.addSubview(previewImageView)
        view.fillSuperview()
        
        
        print("Finish processing photo sample buffer...")
        
    }
}

class CameraController: UIViewController {
    
    let cameraView = CameraContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCapturingPhoto()
        
        view.addSubview(cameraView)
        
        cameraView.fillSuperview()
        
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
