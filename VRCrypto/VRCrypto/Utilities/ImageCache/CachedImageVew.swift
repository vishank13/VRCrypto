//
//  CachedImageView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 27/11/23.
//

import SwiftUI
import Observation

/// A SwiftUI view that loads and caches an image asynchronously from a URL.
///
/// This view attempts to load an image from the given URL using an `ImageLoader`.
/// If the image is successfully loaded, it is displayed as a resizable `Image`.
/// If loading fails, a placeholder system image (`photo`) is shown.
/// While loading, a `ProgressView` is displayed.
///
/// - Parameters:
///   - url: The URL string of the image to load.
///   - onSuccess: An optional closure that gets executed when the image successfully loads (or fails).
///
/// ## Usage:
/// ```swift
/// CachedImageView(url: "https://example.com/image.jpg")
/// ```
struct CachedImageView: View {
    
    /// The image loader responsible for fetching and caching the image.
    var imageLoader: ImageLoader
    
    /// Closure executed when the image successfully loads or fails.
    var onSuccess: (() -> Void)?
    
    /// Initializes a `CachedImageView` with a URL string.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to load.
    ///   - onSuccess: A closure that is called when the image load operation completes.
    init(url: String,
         onSuccess: (() -> Void)? = nil) {
        imageLoader = ImageLoader(url: url)
        self.onSuccess = onSuccess
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .onAppear {
                    self.onSuccess?()
                }
        } else if imageLoader.imageFetchFailed {
            Image(systemName: "photo")
                .resizable()
                .onAppear {
                    self.onSuccess?()
                }
        } else {
            ProgressView()
        }
    }
}
