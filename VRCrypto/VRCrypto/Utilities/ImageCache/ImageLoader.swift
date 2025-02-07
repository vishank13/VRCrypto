//
//  ImageLoader.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import UIKit

/// A class responsible for asynchronously loading images from a given URL.
///
/// `ImageLoader` checks for cached images before making a network request, reducing unnecessary downloads.
/// It also handles image fetching failures and updates its state accordingly.
///
/// ## Features:
/// - **Caching Support**: Uses `ImageCache` to store and retrieve images.
/// - **Asynchronous Loading**: Fetches images in the background to avoid blocking the UI.
/// - **Error Handling**: Sets `imageFetchFailed` to `true` if fetching fails.
/// - **Automatic Image Updating**: Updates `image` when the download is complete.
///
/// ## Example Usage:
/// ```swift
/// @StateObject var imageLoader = ImageLoader(url: "https://example.com/image.jpg")
///
/// if let image = imageLoader.image {
///     Image(uiImage: image)
///         .resizable()
///         .scaledToFit()
/// } else if imageLoader.imageFetchFailed {
///     Text("Failed to load image")
/// } else {
///     ProgressView() // Show loader while fetching
/// }
/// ```
@Observable
class ImageLoader {
    
    /// The loaded image, if available.
    var image: UIImage?
    
    /// A flag indicating whether image fetching failed.
    var imageFetchFailed: Bool = false
    
    /// The image URL as a string.
    private var url: String
    
    /// The ongoing network task (if any).
    private var task: URLSessionDataTask?
    
    /// Initializes `ImageLoader` with a given URL and starts loading the image.
    ///
    /// - Parameter url: The URL string of the image to be fetched.
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    /// Loads the image from cache or fetches it from the server if not available in cache.
    private func loadImage() {
        // Check if the image is already cached
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            print("Loaded from Cache!!!!!!")
            self.image = cachedImage
            return
        }
        
        // Validate URL
        guard let url = URL(string: url) else {
            self.imageFetchFailed = true
            return
        }
        
        // Start network request to fetch the image
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data, error == nil else {
                DispatchQueue.main.async {
                    self?.imageFetchFailed = true
                }
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                    print("Loaded from Server!!!!!! \(url)")
                    ImageCache.shared.set(image, forKey: self.url)
                } else {
                    self.imageFetchFailed = true
                }
            }
        }
        
        task?.resume()
    }
}
