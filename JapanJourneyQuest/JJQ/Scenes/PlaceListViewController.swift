//
//  PlaceListViewController.swift
//  JJQ
//
//  Created by 藤井陽介 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit
import SDWebImage

class PlaceListViewController: UIViewController {

    let apiManager = APIManager.shared

    @IBOutlet weak var tableView: UITableView! {

        didSet {

            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(PlaceListTableViewCell.self)
            let baseView = UIView()
            baseView.backgroundColor = UIColor.JJQ.base
            tableView.tableFooterView = baseView
        }
    }

    var tourspots: [Tourspot] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setupBarColor()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let url = apiManager.templateRequest {

            apiManager.getInformations(url, { [weak self] tourspots in
                guard let self = self else { return }

                self.tourspots = tourspots
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
}

extension PlaceListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourspots.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

        cell.nameLabel.text = tourspots[indexPath.row].name.name1?.written ?? "No Name"
        cell.placeImageView.sd_setImage(with: apiManager.createImageRequest(tourspots[indexPath.row].views?.first, tourspots[indexPath.row].mng),
                                        placeholderImage: #imageLiteral(resourceName: "no_image"),
                                        completed: nil)
        return cell
    }
}

extension PlaceListViewController: UITableViewDelegate {
}
