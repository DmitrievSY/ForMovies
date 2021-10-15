// ImageAPIService.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol ImageAPIServiceProtocol {
    func getPhoto(url: URL, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}

final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Privat property

    private let urlStaticPart = "https://image.tmdb.org/t/p/w500"

    // MARK: - Internal method

    func getPhoto(url: URL, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let urlString = url.absoluteString
        guard let imageURL = URL(string: urlStaticPart + urlString) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}
