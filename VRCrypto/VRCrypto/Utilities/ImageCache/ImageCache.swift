//
//  ImageCache.swift
//  tmdb
//
//  Created by Vishank Raghav on 27/11/23.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 500
        cache.totalCostLimit = 1024 * 1024 * 200 // 200MB
    }

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func removeCache() {
        self.cache.removeAllObjects()
    }
}
