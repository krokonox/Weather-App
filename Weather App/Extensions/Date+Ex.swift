//
//  Date+Ex.swift
//  Weather App
//
//  Created by Admin on 24/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension Date {
    func getTodayWeekDay() -> String {
        var day = ""
        let calender = Calendar(identifier: .gregorian)
        let comps = calender.dateComponents([.weekday], from: self)
        let today = comps.weekday!
        
        switch today {
        case 1: day = "Sunday"
        case 2: day = "Monday"
        case 3: day = "Tuesday"
        case 4: day = "Wednesday"
        case 5: day = "Thursday"
        case 6: day = "Friday"
        case 7: day = "Saturday"
        default: day = ""
        }
        
        return day
    }
    
    func getHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let hour = formatter.string(from: self)
        
        return hour
    }
}
