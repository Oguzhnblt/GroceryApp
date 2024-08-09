//
//  AsyncImageView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 7.08.2024.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var uiImage: UIImage?
    let url: URL?
    let placeholder: Image
    let imageCache = ImageCache.shared

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        guard let url = url else { return }
        
        if let cachedImage = imageCache.getImage(forKey: url.absoluteString) {
            self.uiImage = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            imageCache.setImage(image, forKey: url.absoluteString)
            
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }.resume()
    }
}
