//
//  PlaceListViewController.swift
//  JJQ
//
//  Created by 藤井陽介 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet

class PlaceListViewController: UIViewController {

    let apiManager = APIManager.shared

    @IBOutlet weak var tableView: UITableView! {

        didSet {

            tableView.dataSource = self
            tableView.delegate = self
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            tableView.register(PlaceListTableViewCell.self)
            tableView.tableFooterView = UIView()
            tableView.refreshControl = refreshControll
        }
    }
    var refreshControll = UIRefreshControl()

    var tourspots: [Tourspot] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setupBarColor()
        refreshControll.addTarget(self, action: #selector(refreshData), for: .valueChanged)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetail",
            let viewController = segue.destination as? DetailViewController,
            let value = sender as? Tourspot {

            viewController.spot = value
        }
    }

    @objc func refreshData() {

        if let url = apiManager.templateRequest {

            apiManager.getInformations(url, { [weak self] tourspots in
                guard let self = self else { return }

                self.tourspots = tourspots
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControll.endRefreshing()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: tourspots[indexPath.row])
    }
}

extension PlaceListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "back_cover")
    }
}
