// FilmsViewModel.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol FilmsViewModelProtocol {
    var films: Category? { get set }
    var reloadData: (() -> ())? { get set }
    func imageRequest(row: Int, completion: @escaping (UIImage) -> ())
}

final class FilmsViewModel: FilmsViewModelProtocol {
    // MARK: - Internal Property

    var films: Category?
    var reloadData: (() -> ())?

    // MARK: - Private enum

    private enum TextForURL: String {
        case requestURL =
            "https://api.themoviedb.org/3/movie/popular?api_key=e318d66f1eef01b2c45127e1e13922a7&language=ru-RU"
        case error = "Error serialization json"
    }

    // MARK: - Init

    init() {
        parsingFilms()
    }

    // MARK: - Private methods

    private func parsingFilms() {
        guard let pageOneURL =
            URL(
                string: TextForURL.requestURL.rawValue
            )
        else { return }
        URLSession.shared.dataTask(with: pageOneURL) { data, _, error in
            guard error == nil else { return print(TextForURL.error) }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let films = try decoder.decode(Category.self, from: data)

                self.films = films
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            } catch {
                print(TextForURL.error, error)
            }
        }.resume()
    }

    // MARK: - Public methods

    func imageRequest(row: Int, completion: @escaping (UIImage) -> ()) {
        var image = UIImage()
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (films?.results[row].posterPath ?? ""))
        else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data else { return }
            image = UIImage(data: data) ?? UIImage()
            completion(image)
        }.resume()
    }
}
