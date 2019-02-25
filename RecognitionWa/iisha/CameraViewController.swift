//
//  CameraViewController.swift
//  iisha
//
//  Created by 張翔 on 2018/12/28.
//  Copyright © 2018 張翔. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class CameraViewController: UIViewController {
    
    @IBOutlet var adBannerView: GADBannerView!
    @IBOutlet var shutterButton: UIButton!
    @IBOutlet var cameraView: UIView!
    @IBOutlet var flushModeButton: UIButton!
    var camera: Camera!
    var hasTakenPicture = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAd()
        setupUI()
        setupCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        camera.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        camera.stop()
    }
    
    func setupAd() {
        adBannerView.adUnitID = AdManager.cameraBannerID
        adBannerView.rootViewController = self
        adBannerView.delegate = self
        adBannerView.load(GADRequest())
    }
    
    func setupUI() {
        shutterButton.layer.cornerRadius = shutterButton.frame.size.width / 2
        shutterButton.layer.borderColor = UIColor.dark.cgColor
        shutterButton.layer.borderWidth = 3
    }
    
    func setupCamera() {
        camera = Camera()
        camera.delegate = self
        camera.cameraPreviewLayer.frame.size = cameraView.frame.size
        cameraView.layer.insertSublayer(camera.cameraPreviewLayer, at: 0)
        camera.start()
    }
    
    @IBAction func shutter() {
        if !hasTakenPicture {
            camera.shutter()
            hasTakenPicture = true
        }
    }
    
    @IBAction func changeFlashMode() {
        switch camera.changeFlashMode() {
        case .auto:
            flushModeButton.setImage(#imageLiteral(resourceName: "Flash-auto"), for: .normal)
        case .on:
            flushModeButton.setImage(#imageLiteral(resourceName: "Flash-on"), for: .normal)
        case .off:
            flushModeButton.setImage(#imageLiteral(resourceName: "Flash-off"), for: .normal)
        }
    }
    
    @IBAction func changeCamera() {
        camera.changeCamera()
    }

}

extension CameraViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBannerView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.adBannerView.alpha = 1
        }
    }
}

extension CameraViewController: CameraDelegate {
    func photoOutput(_ image: UIImage) {
        let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Result") as! ResultViewController
        resultViewController.image = image
        resultViewController.modalTransitionStyle = .flipHorizontal
        present(resultViewController, animated: true) {
            self.hasTakenPicture = false
        }
    }
}
