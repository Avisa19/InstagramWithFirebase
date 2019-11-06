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
          
          output.capturePhoto(with: settings, delegate: self)
      }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("Capture failed: \(error.localizedDescription)")
        }

    
        
        
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
