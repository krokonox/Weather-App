//
//  CitiesTableViewDS.swift
//  Weather App
//
//  Created by Admin on 27/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CitiesTableViewDS: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let cities: [String] = Cities.allCases.map { $0.rawValue }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
        if let cell = cell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = cities[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = Interface.sh.tabBarController.viewControllers?[0] as? WeatherViewController {
            vc.city = cities[indexPath.row]
            Interface.sh.presentVC(vc: vc)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
