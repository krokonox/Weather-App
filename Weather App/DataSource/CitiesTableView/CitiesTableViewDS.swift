//
//  CitiesTableViewDS.swift
//  Weather App
//
//  Created by Admin on 27/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol CitiesTableViewDelegate: class {
    func cityDidSelected(_ city: String)
}

class CitiesTableViewDS: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let cities: [String] = []
    weak var delegate: CitiesTableViewDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
        if let cell = cell {
            cell.selectionStyle = .none
            cell.textLabel?.text = cities[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.cityDidSelected(cities[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}
