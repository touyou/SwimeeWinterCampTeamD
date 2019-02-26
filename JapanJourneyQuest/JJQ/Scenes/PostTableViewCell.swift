//
//  PostTableViewCell.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibLoadable, Reusable {
    
    @IBOutlet var imageView0: UIImageView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imageView4: UIImageView!
    @IBOutlet var selectImageButton: UIButton!
    @IBOutlet var textView: UITextView!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var rating: Item.ItemRating = .star0 {
        didSet {
            for imageView in imageViewArray[0...rating.rawValue - 1] {
                imageView.image = UIImage.Star.dark
            }
            if rating != .star5 {
                for imageView in imageViewArray[rating.rawValue...4] {
                    imageView.image = UIImage.Star.light
                }
            }
        }
    }
    
    
    var imageViewArray: [UIImageView]!
    var spot: Tourspot!
    var postImage: UIImage?
    
    weak var delegate: PostTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewArray = [imageView0, imageView1, imageView2, imageView3, imageView4]
        
        imageView0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped0)))
        imageView1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped1)))
        imageView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped2)))
        imageView3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped3)))
        imageView4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped4)))
        
        
        selectImageButton.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func tapped0() {
        rating = Item.ItemRating(rawValue: 1)!
    }
    
    @objc func tapped1() {
        rating = Item.ItemRating(rawValue: 2)!
    }
    
    @objc func tapped2() {
        rating = Item.ItemRating(rawValue: 3)!
    }
    
    @objc func tapped3() {
        rating = Item.ItemRating(rawValue: 4)!
    }
    
    @objc func tapped4() {
        rating = Item.ItemRating(rawValue: 5)!
    }
    
    @IBAction func selectImage() {
        let c = UIImagePickerController()
        c.delegate = self
        UIApplication.shared.topPresentedViewController?.present(c, animated: true)
    }
    
    @IBAction func post() {
//        guard let image = postImage else {
//            return
//        }
        
        let _ = UIAlertController(title: "Did you post?", message: "", preferredStyle: .alert)
            .addAction(title: "Yes", style: .default, handler: { action in
//                ItemManager.shared.post(tourspot: self.spot, image: image, comment: self.textView.text, rating: self.rating) { (error) in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        print("completed")
//                    }
//                }
                ItemManager.shared.saveItemToUserDefaults(Item(id: self.spot.mng.refbase, name: self.spot.name.name1?.written ?? "", jewelID: Int.random(in: 0..<11)))
            })
            .addAction(title: "Cancel", style: .cancel, handler: nil)
            .show()
    }
    
}

extension PostTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
//            selectImageButton.setImage(pickedImage, for: .normal)
//            selectedImageView.image = pickedImage
            postImage = pickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
