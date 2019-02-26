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
    
    
    func getItemsFromUserDefaults() -> [Data] {
        if let items = userDefaults.array(forKey: "items") as? [Data] {
            return items
        } else {
            return []
        }
    }
    
    func setItemArrayToUserDefaults(_ itemArray: [Data]) {
        userDefaults.set(itemArray, forKey: "items")
    }
    
    func saveItemToUserDefaults(_ item: Item) {
        var items = getItemsFromUserDefaults()
        guard let data = try? JSONEncoder().encode(item) else { return }
        items.append(data)
        setItemArrayToUserDefaults(items)
    }
    
    func post(tourspot: Tourspot, image: UIImage, comment: String, rating: Item.ItemRating, completion: @escaping (_ error: Error?) -> Void) {
        let placeIDString = tourspot.mng.refbase
        let imageRef = storage.reference(withPath: "image/\(placeIDString).jpg")
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(postError.cannotConvertJPEG)
            return
        }
        
        imageRef.putData(imageData, metadata: nil) {[weak self] (_, error) in
            if let error = error{
                completion(error)
            } else {
                let item = Item(id: placeIDString, name: tourspot.name.name1?.written ?? "", jewelID: Int.random(in: 0...11))
                self?.saveItemToUserDefaults(item)
                completion(nil)
            }
        }
    }
    
    enum postError: Error {
        case cannotConvertJPEG
    }
}

