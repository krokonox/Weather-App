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
    var currentLocation: CLLocation?
    
    var delegate: LocationUpdateProtocol?
    
    private override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    private func checkLocationsService(closure: () -> ()) {
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            print("위치 허용상태")
        } else {
            let message = "Allow location Services?"
            self.showAlert(title: "", message: message)
        }
        
//        if CLLocationManager.locationServicesEnabled() {
//            closure()
//        }
//        else {
//            DispatchQueue.main.async {
//                self.showAlert(title: "Sorry", message: "Allow location services?")
//            }
//        }
    }
    
    private func getCurrentLocation() -> CLLocationCoordinate2D? {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        return locationManager.location?.coordinate
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
