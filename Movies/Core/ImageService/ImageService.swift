// ImageService.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol ImageServiceProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

final class ImageService: ImageServiceProtocol {
    // MARK: - Public Methods

    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        let imageAPIService = ImageAPIService()
        let cacheImageService = CacheImageService()
        let proxy = Proxy(imageAPIService: imageAPIService, cacheImageService: cacheImageService)

        proxy.loadImage(url: url) { result in
            switch result {
            case let .success(image):
                completion(image)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
