//
//  LocationManager.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 27.07.2022.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject  {
    func getLocation(location: CLLocationCoordinate2D)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationManagerDelegate?
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    var location : CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    private override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func startOnlyUpdate(){
        locationManager.startUpdatingLocation()
    }
    
    func startForBackground(){
        if (CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager.pausesLocationUpdatesAutomatically = true
            if #available(iOS 14.0, *) {
                locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            } else {
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            }
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
          return
        }

        location = currentLocation
        checkLastLocationSendDate(location: location.coordinate)
        delegate?.getLocation(location: currentLocation.coordinate)
        print("\(currentLocation.coordinate.latitude)-\(currentLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }else{
            locationManager.pausesLocationUpdatesAutomatically = true
            if #available(iOS 14.0, *) {
                locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            } else {
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            }
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func stopper(){
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func isDetermined() -> Bool{
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
            return false
        }else{
            stopper()
            startLocManager()
            return true
        }
    }
    
    func startLocManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = true
        if #available(iOS 14.0, *) {
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }//RUK
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func startLocationTracking(){
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startMonitoringSignificantLocationChanges()
    }

    @objc func finalizer() {
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            if let dele = self.delegate {
               // dele.getLocation()
                if #available(iOS 14.0, *) {
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyReduced
                } else {
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                }//RUK
            //    self.myDelegate = nil
            }
        }
    }
    
    func checkLastLocationSendDate(location: CLLocationCoordinate2D) {
    }
    
    func sendLocationToApi(location: CLLocationCoordinate2D) {

    }
    
    @objc func getLocationTrackingRequest(_ notification: Notification) {
    }
}


