//
//  LocationManager.swift
//  Weather App
//
//  Created by Admin on 26/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdate(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sh = LocationManager()
    
    private var locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    var currentLocation: CLLocation?
    
    var delegate: LocationUpdateProtocol?
    
    private override init() {
        super.init()
    }
    
    func checkLocationsService() {
        self.locationManager.delegate = self
        
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            print("")
        }
        else {
            let message = "Open settings?"
            DispatchQueue.main.async {
                self.showAlert(title: "", message: message)
            }
        }
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
    }
    
    func getCurrentLocation(completion: @escaping (Location) -> ()) {
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            self.convertCoordinatesToLocation(coordinares: location) { location in
                completion(location)
            }
        }
    }
    
    func convertCoordinatesToLocation(coordinares: CLLocation, completion: @escaping (_ location: Location) -> ()) {
        geoCoder.reverseGeocodeLocation(coordinares, completionHandler: { (placemarks, _) -> Void in
            
            guard let placemark = placemarks?.first else { return }
            let location = Location(with: placemark)
            completion(location)
        })
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(UIAlertAction(title: "Open Settings?", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }))
        alert.addAction(okAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true)
    }
}
