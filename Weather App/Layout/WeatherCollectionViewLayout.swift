//
//  WeatherCollectionViewLayout.swift
//  Weather App
//
//  Created by Admin on 23/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeatherCollectionViewLayout: UICollectionViewLayout {
    enum ElementType: String {
        case WeatherHeaderView
        case TodayWeather
        case HourlyWeather
        case WeatherSummury
        case WeatherByDays
        case ExtendedInfoWeather
        
        var id: String {
            return self.rawValue
        }
        
        var kind: String {
            return "Kind\(self.rawValue.capitalized)"
        }
    }
    
    var attributes: [UICollectionViewLayoutAttributes] = []
    
    override class var layoutAttributesClass: AnyClass {
        return WeatherCollectionLayoutAttributes.self
    }
    
    private var collectionViewHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.height
    }
    
    private var collectionViewWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.frame.width - (insets.left + insets.right)
    }
    
    private let numberOfColumn = 4
    private var oldBounds: CGRect = .zero
    private var visibleAttributes: [WeatherCollectionLayoutAttributes] = []
    private var cache = [ElementType: [IndexPath: WeatherCollectionLayoutAttributes]]()
    private var contentHeight = CGFloat()
    private var zIndex = 0
    
    private var contentOffset: CGPoint {
        guard let collectionView = collectionView else { return CGPoint.zero }
        return collectionView.contentOffset
    }
    
    var headerSize: CGSize = .zero
    var todayWeatherCell: CGSize = .zero
    var hourlyWeatherCell: CGSize = .zero
    var weeklyWeatherCell: CGSize = .zero
    var summuryWeatherCell: CGSize = .zero
    var extendedInfoWeatherCell: CGSize = .zero
    
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if oldBounds.size != newBounds.size {
            cache.removeAll(keepingCapacity: true)
        }
        return true
    }
    
    func prepareCache() {
        cache.removeAll(keepingCapacity: true)
        cache[.WeatherHeaderView] = [IndexPath: WeatherCollectionLayoutAttributes]()
        cache[.TodayWeather] = [IndexPath: WeatherCollectionLayoutAttributes]()
        cache[.HourlyWeather] = [IndexPath: WeatherCollectionLayoutAttributes]()
        cache[.WeatherByDays] = [IndexPath: WeatherCollectionLayoutAttributes]()
        cache[.WeatherSummury] = [IndexPath: WeatherCollectionLayoutAttributes]()
        cache[.ExtendedInfoWeather] = [IndexPath: WeatherCollectionLayoutAttributes]()
    }
    
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        prepareCache()
        contentHeight = 0
        oldBounds = collectionView.bounds
        
        let headerAttributes = WeatherCollectionLayoutAttributes(forSupplementaryViewOfKind: ElementType.WeatherHeaderView.kind, with: IndexPath(item: 0, section: 0))
        prepareElement(size: headerSize, type: .WeatherHeaderView, attributes: headerAttributes)
        
        let todayWeatherAttributes = WeatherCollectionLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))
        prepareElement(size: todayWeatherCell, type: .TodayWeather, attributes: todayWeatherAttributes)
        
        
        let hourlyAttributes = WeatherCollectionLayoutAttributes(forCellWith: IndexPath(item: 0, section: 2))
        prepareElement(size: hourlyWeatherCell, type: .HourlyWeather, attributes: hourlyAttributes)
        
        let weeklyWeatherAttributes = WeatherCollectionLayoutAttributes(forCellWith: IndexPath(item: 0, section: 1))
        prepareElement(size: weeklyWeatherCell, type: .WeatherByDays, attributes: weeklyWeatherAttributes)
        
        let summuryWeatherAttributes = WeatherCollectionLayoutAttributes(forCellWith: IndexPath(item: 0, section: 1))
        prepareElement(size: weeklyWeatherCell, type: .WeatherSummury, attributes: summuryWeatherAttributes)
               
        let detailAttributes = WeatherCollectionLayoutAttributes(forCellWith: IndexPath(item: 0, section: 3))
        prepareElement(size: extendedInfoWeatherCell, type: .ExtendedInfoWeather, attributes: detailAttributes)
        

        cache[.WeatherHeaderView]?.first?.value.zIndex = zIndex + 1
        cache[.TodayWeather]?.first?.value.zIndex = zIndex + 2
    }
    
    func prepareElement(size: CGSize, type: ElementType, attributes: WeatherCollectionLayoutAttributes) {
        guard size != .zero else { return }
        
        attributes.initialOrigin = CGPoint(x: 0, y: contentHeight)
        attributes.frame = CGRect(origin: CGPoint(x: 0, y: contentHeight), size: size)
        attributes.zIndex = zIndex
        zIndex += 1
        
        contentHeight = attributes.frame.maxY
    }
}

extension WeatherCollectionViewLayout {
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case ElementType.WeatherHeaderView.kind:
            return cache[.WeatherHeaderView]?[indexPath]
        default:
            return UICollectionViewLayoutAttributes()
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        visibleAttributes.removeAll(keepingCapacity: true)
        
        for (type, elementInfo) in cache {
            for (indexPath, attributes) in elementInfo {
                attributes.transform = .identity
                updateStickyViews(type, attributes: attributes, collectionView: collectionView, indexPath: indexPath)
                if attributes.frame.intersects(rect) {
                    visibleAttributes.append(attributes)
                }
            }
        }
        return visibleAttributes
    }
    
    private func updateStickyViews(_ type: ElementType, attributes: WeatherCollectionLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
        if type == .WeatherHeaderView {
            let limitHeight = headerSize.height - todayWeatherCell.height
            let updatedHeight = headerSize.height - contentOffset.y
            let resultHeight = min(headerSize.height, max(limitHeight, updatedHeight))
            attributes.frame = CGRect(origin: CGPoint(x: 0, y: contentOffset.y), size: CGSize(width: headerSize.width, height: resultHeight))
            attributes.headerAlpha = 1 - (contentOffset.y / todayWeatherCell.height)
        }
        else if type == .TodayWeather {
            let upperLimit = (headerSize.height / 2) + 30
            let initY = upperLimit - headerSize.height
            let updatedY = contentOffset.y - attributes.initialOrigin.y - initY
            attributes.transform = CGAffineTransform(translationX: 0, y: max(0, updatedY))
        }
    }
}
