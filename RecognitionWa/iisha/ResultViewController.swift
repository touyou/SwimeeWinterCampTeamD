//
//  ResultViewController.swift
//  iisha
//
//  Created by 張翔 on 2018/12/29.
//  Copyright © 2018 張翔. All rights reserved.
//

import UIKit
import Firebase
import CoreML
import Vision
import Photos
import Accounts

class ResultViewController: UIViewController {
    
    @IBOutlet var adBannerView: GADBannerView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var saveButtonImageView: UIImageView!
    @IBOutlet var saveButtonIndicator: UIActivityIndicatorView!
    
    var image: UIImage!
    var grader = Grader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAd()
        setupUI()
        grader.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        grader.perform(image)
    }
    
    func setupAd() {
        adBannerView.adUnitID = AdManager.resultBannerID
        adBannerView.rootViewController = self
        adBannerView.delegate = self
        adBannerView.load(GADRequest())
    }
    
    func setupUI() {
        saveButton.layer.cornerRadius = saveButton.frame.size.width / 2
        imageView.image = image
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func twitter() {
        
    }
    
    @IBAction func line() {
        let pasteBoard = UIPasteboard.general
        pasteBoard.setData(image.jpegData(compressionQuality: 1.0)!, forPasteboardType: "public.jpeg")
        let scheme: String = "line://msg/image/" + pasteBoard.name.rawValue
        let url: URL = URL(string: scheme)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func instagram() {
        var localId: String?
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            localId = request.placeholderForCreatedAsset?.localIdentifier
        }, completionHandler: { success, error in
            if let localId = localId {
                let urlString = "instagram://library?LocalIdentifier=" + localId
                guard let url = URL(string: urlString) else {
                    return
                }
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
    }

    @IBAction func others() {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func save() {
        saveButtonImageView.alpha = 0
        saveButtonIndicator.alpha = 1
        saveButtonIndicator.startAnimating()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(finishSave(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @objc func finishSave(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer) {
        if let _ = error {
            saveButtonIndicator.alpha = 0
            saveButtonIndicator.stopAnimating()
            saveButtonImageView.alpha = 1
        } else {
            saveButtonIndicator.alpha = 0
            saveButtonIndicator.stopAnimating()
            saveButtonImageView.image = #imageLiteral(resourceName: "Finish")
            saveButtonImageView.alpha = 1
            saveButton.isUserInteractionEnabled = false
        }
    }
}

extension ResultViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBannerView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.adBannerView.alpha = 1
        }
    }
}

extension ResultViewController: GraderDelegate {
    func finish(score: Int) {
        let stringAttributes1: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.dark,
            .font : UIFont.systemFont(ofSize: 80, weight: .bold)
        ]
        let string1 = NSAttributedString(string: String(score), attributes: stringAttributes1)
        
        let stringAttributes2: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.dark,
            .font : UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        let string2 = NSAttributedString(string: "/100", attributes: stringAttributes2)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        
        scoreLabel.attributedText = mutableAttributedString
    }
}
