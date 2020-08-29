//
//  Interface.swift
//  Weather App
//
//  Created by Admin on 28/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class Interface {
    
    static let sh = Interface()
    
    private weak var window: UIWindow?
    
    lazy var tabBarController = TabBarController()
    private lazy var rootController = RootViewController()
    
    private init() {}
    
    func setup(window: UIWindow) {
        self.window = window
        window.rootViewController = rootController
        window.makeKeyAndVisible()
    }
    
    func setupTabViewController() {
        tabBarController.setDelegate(rootVC: rootController)
        self.window?.rootViewController = tabBarController
    }
    
    func presentVC(vc: UIViewController) {
        self.tabBarController.selectedViewController = tabBarController.weatherVC
        print("present")
    }
}
