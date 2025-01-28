//
//  RecipesImageService.swift
//  FetchMealsChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation
import SwiftUI

// Responsible to provide images
final class RecipesImageService {

    private var imageChache = NSCache<AnyObject, UIImage>()
    private let session = URLSession.shared
    static let shared = RecipesImageService()

    func loadRecipeImage(with url: String, completion: @escaping (UIImage?) -> ()) {

        let key = NSString(string: url)

        // check if we have image stored in cache
        if let image = imageChache.object(forKey: key) {
            completion(image)
        }

        guard let url = URL(string: url) else {
            completion(nil)
            return
        }

        let request = URLRequest(url: url)

        session.dataTask(with: request) { [weak self] data, response, error in

            guard let self = self else { return }

            if let data = data, let image = UIImage(data: data) {

                // store image in cache first
                self.imageChache.setObject(image, forKey: key)

                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }

    // clear the image cache data
    func clearImageCache() {
        imageChache.removeAllObjects()
    }

}
