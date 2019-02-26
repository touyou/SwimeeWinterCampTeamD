//
//  ItemListViewController.swift
//  
//
//  Created by 藤井陽介 on 2019/02/26.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var items: [Item]!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let itemsData = ItemManager.shared.getItemsFromUserDefaults()
        items = []
        for data in itemsData {
            guard let item = try? JSONDecoder().decode(Item.self, from: data) else { continue }
            items.append(item)
        }
        collectionView.reloadData()

        navigationController?.setupBarColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        let itemsData = ItemManager.shared.getItemsFromUserDefaults()
        items = []
        for data in itemsData {
            guard let item = try? JSONDecoder().decode(Item.self, from: data) else { continue }
            items.append(item)
        }
        collectionView.reloadData()
    }

}

extension ItemListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemCollectionViewCell
        cell.setup(item: items[indexPath.row])
        return cell
    }
    
    
}
