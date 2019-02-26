//
//  MapTableViewCell.swift
//  JJQ
//
//  Created by 藤井陽介 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, NibLoadable, Reusable {
    @IBOutlet weak var placeMapView: MKMapView! {

        didSet {

            setCenter()
        }
    }

    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCenter() {

        if placeMapView != nil,
            let latitude = latitude,
            let longitude = longitude {

            let center = CLLocationCoordinate2DMake(latitude, longitude)
            placeMapView.setCenter(center, animated: true)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: center, span: span)
            placeMapView.region = region

            let pin = MKPointAnnotation()
            pin.coordinate = center
            placeMapView.addAnnotation(pin)
        }
    }
}
