//
//  TabBarController.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let weatherVC = WeatherViewController()
    let citiesVC = CitiesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        self.view.backgroundColor = .white
        self.tabBar.tintColor = UIColor(named: "SkyBlue")
        self.tabBar.barTintColor = .white
        
        weatherVC.tabBarItem.image = UIImage(named: "WeatherTab")
    
        citiesVC.tabBarItem.image = UIImage(named: "CityTab")
        
        self.viewControllers = [weatherVC, citiesVC]
        
    }
    
     func setDelegate(rootVC: RootViewController) {
        rootVC.delegate = weatherVC
    }
}
