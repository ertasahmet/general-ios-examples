//
//  LocationTrackingViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 27.07.2022.
//

import UIKit
import CoreLocation

class LocationTrackingViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeLocationServices()
    }

    private func initializeLocationServices() {
        LocationManager.shared.delegate = self
        LocationManager.shared.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        LocationManager.shared.startLocationTracking()
    }
    
    private func sendLocation(_ location: String) {
        // send location
        print(location)
    }
    
}

extension LocationTrackingViewController : LocationManagerDelegate {
    func getLocation(location: CLLocationCoordinate2D) {
        let locationString = "\(location.latitude), \(location.longitude)"
        sendLocation(locationString)
    }
    
    
}
