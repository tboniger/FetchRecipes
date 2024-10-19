//
//  ImageLoader.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation
import UIKit

class ImageLoader {
    
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadImage(from string: String?) async -> UIImage? {

        guard let str = string, let url = URL(string: str) else {
            return nil
        }
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }

        do {
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return nil
            }

            guard let image = UIImage(data: data) else {
                return nil
            }

            cache.setObject(image, forKey: url as NSURL)

            return image
    
        } catch {
            return nil
        }
    
    }
    
}
