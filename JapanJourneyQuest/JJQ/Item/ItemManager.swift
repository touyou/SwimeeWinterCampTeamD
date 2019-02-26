//
//  ItemManager.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import Foundation

class ItemManager {
    static let shared = ItemManager()
    
    private init() {
    }
    
     var userDefaults = UserDefaults.standard
    
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
}
