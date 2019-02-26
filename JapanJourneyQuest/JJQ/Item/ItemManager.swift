//
//  ItemManager.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ItemManager {
    static let shared = ItemManager()
    
    private init() {
    }
    
    let userDefaults = UserDefaults.standard
    let storage = Storage.storage()
    
    
    func getItemsFromUserDefaults() -> [Item] {
        if let items = userDefaults.array(forKey: "items") as? [Item] {
            return items
        } else {
            return []
        }
    }
    
    func setItemArrayToUserDefaults(_ itemArray: [Item]) {
        userDefaults.set(itemArray, forKey: "items")
    }
    
    func saveItemToUserDefaults(_ item: Item) {
        var items = getItemsFromUserDefaults()
        items.append(item)
        setItemArrayToUserDefaults(items)
    }
    
    func post(placeID: Int, placeName: String, image: UIImage, comment: String, rating: Item.ItemRating, completion: @escaping (_ error: Error?) -> Void) {
        let placeIDString = String(placeID)
        let imageRef = storage.reference(withPath: "image/\(placeIDString).jpg")
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(postError.cannotConvertJPEG)
            return
        }
        
        imageRef.putData(imageData, metadata: nil) {[weak self] (_, error) in
            if let error = error{
                completion(error)
            } else {
                let item = Item(id: placeID, name: placeName, jewelID: Int.random(in: 0...11), imageRef: imageRef, comment: comment, rating: rating)
                self?.saveItemToUserDefaults(item)
                completion(nil)
            }
        }
    }
    
    enum postError: Error {
        case cannotConvertJPEG
    }
}

