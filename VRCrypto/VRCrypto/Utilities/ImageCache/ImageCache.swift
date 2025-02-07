//
//  ImageCache.swift
//  tmdb
//
//  Created by Vishank Raghav on 27/11/23.
//

import Foundation
import UIKit

/// A singleton class for caching images using `NSCache`.
///
/// `ImageCache` provides an efficient way to store and retrieve images in memory,
/// reducing unnecessary network calls and improving performance.
///
/// ## Features:
/// - **Singleton Access**: Use `ImageCache.shared` to access the shared instance.
/// - **Memory Optimization**: Limits cache size to 500 images or 200MB.
/// - **Simple API**: Provides methods to add, retrieve, and clear cached images.
///
/// ## Example Usage:
/// ```swift
/// let image = UIImage(named: "example")!
/// ImageCache.shared.set(image, forKey: "exampleKey")
///
/// if let cachedImage = ImageCache.shared.get(forKey: "exampleKey") {
///     print("Image retrieved from cache")
/// }
/// ```
class ImageCache {
    
    /// The shared singleton instance of `ImageCache`.
    static let shared = ImageCache()
    
    /// The underlying `NSCache` used to store images.
    private let cache = NSCache<NSString, UIImage>()

    /// Private initializer to prevent external instantiation.
    private init() {
        cache.countLimit = 500 // Limits the number of images stored
        cache.totalCostLimit = 1024 * 1024 * 200 // Limits cache size to 200MB
    }

    /// Stores an image in the cache with a given key.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to cache.
    ///   - key: A unique `String` key for retrieving the image later.
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    /// Retrieves a cached image for a given key.
    ///
    /// - Parameter key: The unique `String` key used to store the image.
    /// - Returns: The cached `UIImage`, or `nil` if no image is found.
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    /// Clears all images stored in the cache.
    func removeCache() {
        cache.removeAllObjects()
    }
}
