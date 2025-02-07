//
//  AsyncCachedImage.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import SwiftUI

/// A view that asynchronously loads and caches an image, allowing custom rendering for different states.
///
/// `AsyncCachedImage` wraps around `ImageLoader` to handle image caching and loading.
/// It provides a flexible way to display images using a custom content builder based on the loading state.
///
/// ## Features:
/// - **Uses `ImageLoader` for Caching & Fetching**: Reduces unnecessary network requests.
/// - **Flexible UI Rendering**: Uses `AsyncImagePhase` for different loading states.
/// - **Error Handling**: Displays custom UI when image loading fails.
///
/// ## Example Usage:
/// ```swift
/// AsyncCachedImage(url: "https://example.com/image.jpg") { phase in
///     switch phase {
///     case .success(let image):
///         image.resizable().scaledToFit()
///     case .failure:
///         Image(systemName: "xmark.circle") // Show error image
///     case .empty:
///         ProgressView() // Show loader
///     }
/// }
/// ```
struct AsyncCachedImage<Content: View>: View {
    
    /// An instance of `ImageLoader` responsible for fetching the image.
    var imageLoader: ImageLoader
    
    /// A closure that provides the UI based on the image loading phase.
    let content: (AsyncImagePhase) -> Content
    
    /// Initializes `AsyncCachedImage` with a URL and a content builder.
    ///
    /// - Parameters:
    ///   - url: The image URL to fetch.
    ///   - content: A closure that takes `AsyncImagePhase` and returns a view.
    init(url: String,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        imageLoader = ImageLoader(url: url)
        self.content = content
    }
    
    var body: some View {
        if let image = imageLoader.image {
            let imageView = Image(uiImage: image)
            content(.success(imageView))
        } else if imageLoader.imageFetchFailed {
            content(.failure(AsyncCachedImageError.failed))
        } else {
            content(.empty)
        }
    }
}

/// Enum representing possible errors for `AsyncCachedImage`.
enum AsyncCachedImageError: Error {
    case failed
}
