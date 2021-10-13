// ImageAPIService.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol ImageApiServiceProtocol {
    func imageRequest(stringURL: String, completion: @escaping (UIImage) -> ())
}

final class ImageAPIService: ImageApiServiceProtocol {
    // MARK: - Privat property

    private let urlStaticPart = "https://image.tmdb.org/t/p/w500"

    // MARK: - Internal method

    func imageRequest(stringURL: String, completion: @escaping (UIImage) -> ()) {
        var image = UIImage()
        guard let imageURL = URL(string: urlStaticPart + stringURL)
        else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data else { return }
            image = UIImage(data: data) ?? UIImage()
            completion(image)
        }.resume()
    }
}
