//
//  PlaceListTableViewCell.swift
//  
//
//  Created by 藤井陽介 on 2019/02/26.
//

import UIKit

class PlaceListTableViewCell: UITableViewCell, NibLoadable, Reusable {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
