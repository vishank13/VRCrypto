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
