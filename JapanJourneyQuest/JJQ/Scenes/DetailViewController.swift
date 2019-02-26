//
//  DetailViewController.swift
//  JJQ
//
//  Created by 藤井陽介 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {

            tableView.dataSource = self
            tableView.register(SpotTitleTableViewCell.self)
            tableView.register(MapTableViewCell.self)
            tableView.register(DescriptionTableViewCell.self)
            tableView.register(PostTableViewCell.self)
            tableView.tableFooterView = UIView()
        }
    }
    var spot: Tourspot!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 ..< 1:
            let cell: SpotTitleTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.titleLabel.text = spot.name.name1?.written
            return cell
        case 1 ..< 2:
            let cell: MapTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.longitude = spot.place?.coordinate?.longitude ?? 139.7320
            cell.latitude = spot.place?.coordinate?.latitude ?? 35.7090
            cell.setCenter()
            return cell
        case 2 ..< 3:
            let cell: DescriptionTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.descriptionLabel.text = spot.descs?.first?.body ?? "No description"
            return cell
        case 3 ..< 4:
            let cell: PostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.spot = spot
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension DetailViewController: PostTableViewCellDelegate {
    func didTapSelectImage() {
        let c = UIImagePickerController()
        present(c, animated: true)
        print("working!")
    }
    
    
}
