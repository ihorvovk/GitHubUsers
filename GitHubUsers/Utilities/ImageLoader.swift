//
//  ImageLoader.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 29.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionTask? {
        if let cachedImage = imagesCache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let image = UIImage(data: data) {
                self?.imagesCache.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }

        task.resume()
        return task
    }
    
    // MARK: - Implementation
    
    private let imagesCache = NSCache<NSURL, UIImage>()
}
