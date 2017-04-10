//
//  LocationData.swift
//  d05
//
//  Created by Teo FLEMING on 4/10/17.
//  Copyright © 2017 Teo Fleming. All rights reserved.
//

import UIKit
import CoreLocation

class LocationData {
    static var places = [
        ("42", "École trop stylé", CLLocationCoordinate2D(latitude: 48.896597, longitude: 2.318405), UIColor.black),
        ("UCSC", "École moins stylé", CLLocationCoordinate2D(latitude: 37.000283, longitude: -122.062809), UIColor.green),
        ("Princeton", "École un peu stylé", CLLocationCoordinate2D(latitude: 40.345948, longitude: -74.657679), UIColor.orange),
    ]
}
