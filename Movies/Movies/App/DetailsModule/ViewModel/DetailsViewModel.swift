// DetailsViewModel.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol DetailsViewModelProtocol {
    var filmDescription: FilmDescription? { get set }
    var reloadData: (() -> ())? { get set }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    var reloadData: (() -> ())?
    var filmDescription: FilmDescription?
    private let filmNumber: Int

    init(filmNumber: Int) {
        self.filmNumber = filmNumber
        parsingDescription()
    }

    private func parsingDescription() {
        guard let pageDescriptionURL =
            URL(
                string: "https://api.themoviedb.org/3/movie/\(filmNumber)?api_key=e318d66f1eef01b2c45127e1e13922a7&language=ru-RU"
            )
        else { return }

        URLSession.shared.dataTask(with: pageDescriptionURL) { [weak self] data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self?.filmDescription = try decoder.decode(FilmDescription.self, from: data)
                DispatchQueue.main.async {
                    self?.reloadData?()
                }

            } catch {
                print("error")
            }
        }.resume()
    }
}
