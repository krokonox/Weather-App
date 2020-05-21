//
//  TabBarController.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        self.view.backgroundColor = .white
        self.tabBar.tintColor = UIColor(named: "RedColor")
        self.tabBar.barTintColor = .white
        
        let weatherVC = WeatherViewController()
        weatherVC.tabBarItem.image = UIImage(named: "weatherTab")
        weatherVC.title = "Weather"
        
        let citiesVC = CitiesViewController()
        citiesVC.tabBarItem.image = UIImage(named: "cityTab")
        citiesVC.title = "Cities"
        
        self.viewControllers = [weatherVC, citiesVC]
    }
}
