//
//  Camera.swift
//  iisha
//
//  Created by 張翔 on 2018/12/28.
//  Copyright © 2018 張翔. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Camera: NSObject {
    private var captureSession: AVCaptureSession!
    private var mainCamera: AVCaptureDevice!
    private var innerCamera: AVCaptureDevice!
    private var currentDevice: AVCaptureDevice!
    private var photoOutput: AVCapturePhotoOutput!
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer!
    private var flashMode = AVCaptureDevice.FlashMode.auto
    
    weak var delegate: CameraDelegate?
    
    override init() {
        super.init()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    private func setupDevice() {
        let deviceDiscoverrySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        let devices = deviceDiscoverrySession.devices
        
        for device in devices {
            if device.position == .back {
                mainCamera = device
            } else if device.position == .front {
                innerCamera = device
            }
        }
        
        currentDevice = mainCamera
    }
    
    private func setupInputOutput() {
        let captureDeviceInput = try! AVCaptureDeviceInput(device: currentDevice)
        captureSession.addInput(captureDeviceInput)
        photoOutput = AVCapturePhotoOutput()
        photoOutput.connection(with: .video)?.videoOrientation = .portrait
        captureSession.addOutput(photoOutput)
    }
    
    private func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
    }
    
    func changeFlashMode() -> AVCaptureDevice.FlashMode {
        switch flashMode {
        case .auto:
            flashMode = .on
        case .on:
            flashMode = .off
        case .off:
            flashMode = .auto
        }
        return flashMode
    }
    
    func changeCamera() {
        if currentDevice == mainCamera {
            currentDevice = innerCamera
        } else {
            currentDevice = mainCamera
        }
        captureSession.removeInput(captureSession.inputs[0])
        let captureDeviceInput = try! AVCaptureDeviceInput(device: currentDevice)
        captureSession.addInput(captureDeviceInput)
    }
    
    func shutter() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = flashMode
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func start() {
        captureSession.startRunning()
    }
    
    func stop() {
        captureSession.stopRunning()
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let image = UIImage(data: imageData)
            delegate?.photoOutput(image!)
        }
    }
}
