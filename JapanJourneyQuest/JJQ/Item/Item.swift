//
//  Item.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import Foundation
import Firebase

struct Item: Codable {
    var id: String
    var name: String
    var jewelID: Int
//    var imageRef: StorageReference?
//    var comment: String?
//    var rating: ItemRating?
    
//
//    init(id: String, name: String, jewelID: Int, imageRef: StorageReference?, comment: String?, rating: ItemRating?) {
//        self.id = id
//        self.name = name
//        self.jewelID = jewelID
//        self.imageRef = imageRef
//        self.comment = comment
//        self.rating = rating
//    }
    
    enum ItemRating: Int {
        case star0 = 0
        case star1 = 1
        case star2 = 2
        case star3 = 3
        case star4 = 4
        case star5 = 5
    }
}
