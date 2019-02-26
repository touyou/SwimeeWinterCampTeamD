//
//  PostTableViewCell.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var imageView0: UIImageView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imageView4: UIImageView!
    @IBOutlet var selectImageButton: UIButton!
    
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
    
    weak var delegate: PostTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewArray = [imageView0, imageView1, imageView2, imageView3, imageView4]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapped0() {
        rating = Item.ItemRating(rawValue: 1)!
    }
    
    @IBAction func tapped1() {
        rating = Item.ItemRating(rawValue: 2)!
    }
    
    @IBAction func tapped2() {
        rating = Item.ItemRating(rawValue: 3)!
    }
    
    @IBAction func tapped3() {
        rating = Item.ItemRating(rawValue: 4)!
    }
    
    @IBAction func tapped4() {
        rating = Item.ItemRating(rawValue: 5)!
    }
    
    @IBAction func selectImage() {
        delegate?.didTapSelectImage()
    }
    
    @IBAction func post() {
        
        ItemManager.shared.post(placeID: <#T##Int#>, placeName: <#T##String#>, image: <#T##UIImage#>, comment: <#T##String#>, rating: <#T##Item.ItemRating#>, completion: <#T##(Error?) -> Void#>)
    }
    
}

extension PostTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            selectImageButton.setImage(pickedImage, for: .normal)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
