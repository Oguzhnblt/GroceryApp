//
//  FetchImageHelper.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI
import FirebaseStorage

class FetchImageHelper {
    
    static func fetchImageURL(imageName: String, completion: @escaping (URL?, Error?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(imageName)
        
        imageRef.downloadURL { url, error in
            completion(url, error)
        }
    }
    
    static func fetchImageWithCache(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            ImageCache.shared.setImage(image, forKey: url.absoluteString)
            completion(image)
        }.resume()
    }
}

class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private var cache: NSCache<NSString, UIImage> = NSCache()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
