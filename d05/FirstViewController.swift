//
//  FirstViewController.swift
//  d05
//
//  Created by Teo FLEMING on 4/10/17.
//  Copyright © 2017 Teo Fleming. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ColorPointAnnotation: MKPointAnnotation {
    let color: UIColor
    
    init(info: (String, String, CLLocationCoordinate2D, UIColor)) {
        self.color = info.3
        
        super.init()
        
        self.title = info.0
        self.subtitle = info.1
        self.coordinate = info.2
    }
    
    override var description: String {
        return "\(self.title) \(self.subtitle) \(self.coordinate) \(self.color)"
    }
}

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var lastLocation: CLLocation?

    var centerOnSwitch: CLLocationCoordinate2D?
    
    let defaultSpan = MKCoordinateSpanMake(0.05, 0.05)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.mapType = .standard

        for place in LocationData.places {
            let annotation = ColorPointAnnotation(info: place)
            
            mapView.addAnnotation(annotation)
        }
        
        let region = MKCoordinateRegionMake(LocationData.places[0].2, defaultSpan)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if pinView != nil {
            pinView?.annotation = annotation
        }
        else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")

            if let annotation = annotation as? ColorPointAnnotation {
                pinView?.pinTintColor = annotation.color
            }
            
            pinView?.canShowCallout = true
        }
        
        return pinView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let toCenter = centerOnSwitch {
            let region = MKCoordinateRegionMake(toCenter, defaultSpan)
            mapView.setRegion(region, animated: true)
        }
        
        centerOnSwitch = nil
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            print("there shouldn't be a fourth button...")
        }
    }
    
    @IBAction func centerUser(_ sender: UIButton) {
        if let lastLocation = lastLocation {
            let region = MKCoordinateRegionMake(lastLocation.coordinate, defaultSpan)
            mapView.setRegion(region, animated: true)
        } else {
            print("don't know location just yet...")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated location:", locations)
        
        lastLocation = locations[0]
    }
}
