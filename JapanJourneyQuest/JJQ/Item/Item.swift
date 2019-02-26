//
//  Item.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import Foundation
import Firebase

struct Item {
    var id: Int
    var name: String
    var jewelID: Int
    var imageRef: StorageReference
    
    
    init(id: Int, name: String, jewelID: Int, imageRef: StorageReference) {
        self.id = id
        self.name = name
        self.jewelID = jewelID
        self.imageRef = imageRef
    }
}
