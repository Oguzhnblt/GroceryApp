//
//  FetchImageHelper.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import UIKit
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
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let response = response, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
