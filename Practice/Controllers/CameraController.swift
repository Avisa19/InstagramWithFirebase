//
//  CameraController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 5/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    let cameraView = CameraContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(cameraView)
        cameraView.fillSuperview()
        setupCapturingPhoto()
    }
    
    @objc func handleCapturing() {
        print("capturing...")
    }
    
    @objc func handleDismiss() {
        
        dismiss(animated: true, completion: nil)
    }
    
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
        
         let output = AVCapturePhotoOutput()
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
