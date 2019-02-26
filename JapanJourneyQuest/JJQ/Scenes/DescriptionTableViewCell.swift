//
//  DescriptionTableViewCell.swift
//  JJQ
//
//  Created by 藤井陽介 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell, Reusable, NibLoadable {
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
