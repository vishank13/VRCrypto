//
//  CachedImageVew.swift
//  tmdb
//
//  Created by Vishank Raghav on 27/11/23.
//

import SwiftUI
import Observation

struct CachedImageVew: View {
    var imageLoader: ImageLoader
    var onSuccess: (()->Void)?
    
    init(url: String,
         onSuccess: (()->Void)? = nil) {
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
        } else {
            if imageLoader.imageFetchFailed {
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
}

struct AsyncCachedImage<Content: View>: View {
    var imageLoader: ImageLoader
    let content: (AsyncImagePhase)->Content
    
    init(url: String,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        imageLoader = ImageLoader(url: url)
        self.content = content
    }
    
    var body: some View {
        if let image = imageLoader.image {
            let imageView = Image(uiImage: image)
            content(.success(imageView))
        } else {
            if imageLoader.imageFetchFailed {
                content(.failure(AsyncCachedImageError.failed))
            } else {
                content(.empty)
            }
        }
    }
}

@Observable class ImageLoader {
    var image: UIImage?
    var imageFetchFailed: Bool = false
    
    private var url: String
    private var task: URLSessionDataTask?
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            print("From Cache!!!!!!")
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else {
            self.imageFetchFailed = true
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.imageFetchFailed = true
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                    print("From Server!!!!!! \(url)")
                    ImageCache.shared.set(image, forKey: self.url)
                } else {
                    self.imageFetchFailed = true
                }
            }
        }
        task?.resume()
    }
}

enum AsyncCachedImageError: Error {
    case failed
}
