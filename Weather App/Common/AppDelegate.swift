//
//  AppDelegate.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        if let window = window {
            Interface.sh.setup(window: window)
        }
        
        return true
    }
}

