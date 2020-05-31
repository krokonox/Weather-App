//
//  CellName+Ex.swift
//  Weather App
//
//  Created by Admin on 30/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias ReuseIdentifier = String

protocol Reusable {
    static var reuseIdentifier: ReuseIdentifier { get }
}

extension Reusable {
    static var reuseIdentifier: ReuseIdentifier {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}
