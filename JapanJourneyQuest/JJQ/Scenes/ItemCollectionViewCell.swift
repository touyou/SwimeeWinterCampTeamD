//
//  ItemCollectionViewCell.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    func setup(item: Item) {
        nameLabel.text = item.name
        imageView.image = UIImage.gemImage(item.jewelID)
    }
}
