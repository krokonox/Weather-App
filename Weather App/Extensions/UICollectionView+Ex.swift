//
//  UICollectionView+Ex.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>() -> T where T: Reusable {
        register(T.self)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath(for: T.self)) as! T
    }
}
