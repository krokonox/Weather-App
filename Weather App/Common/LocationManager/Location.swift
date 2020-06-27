//
//  Location.swift
//  Weather App
//
//  Created by Admin on 27/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let city: String
    let country: String
    let latitude: String
    let longitude: String
    
    init(with placemark: CLPlacemark) {
        self.city = placemark.locality ?? ""
        self.country = placemark.country ?? ""
        self.latitude = "\(placemark.location?.coordinate.latitude ?? 0.0)"
        self.longitude = "\(placemark.location?.coordinate.longitude ?? 0.0)"
    }
}
