// Proxy.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol LoadImageProtocol {
    func loadImage(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

final class Proxy: LoadImageProtocol {
    // MARK: - Private Properties

    private let imageAPIService: ImageAPIServiceProtocol
    private let cacheImageService: CacheImageServiceProtocol
    private let basePosterUrlString = "https://image.tmdb.org/t/p/w500"

    // MARK: - Init

    init(imageAPIService: ImageAPIServiceProtocol, cacheImageService: CacheImageServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.cacheImageService = cacheImageService
    }

    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: basePosterUrlString + url) else { return }

        let image = cacheImageService.getImageFromCache(url: url.absoluteString)

        if image == nil {
            imageAPIService.getPhoto(url: url) { result in
                switch result {
                case let .success(image):
                    self.cacheImageService.saveImageToCache(url: url.absoluteString, image: image)
                    completion(.success(image))
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } else {
            guard let image = image else { return }
            completion(.success(image))
        }
    }
}
