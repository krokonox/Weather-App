//
//  String+Ex.swift
//  Weather App
//
//  Created by Admin on 23/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
extension String {
    func returnAsDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date
    }
}
