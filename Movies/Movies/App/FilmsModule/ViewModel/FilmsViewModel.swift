// FilmsViewModel.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol FilmsViewModelProtocol {
    var films: [ResultsFilm]? { get set }
    var reloadData: VoidHandler? { get set }
    var showAlert: StringHandler? { get set }
}

final class FilmsViewModel: FilmsViewModelProtocol {
    // MARK: - enum

    private enum TextForURL: String {
        case error = "Error serialization json"
    }

    // MARK: - Internal Property

    var films: [ResultsFilm]?
    var reloadData: VoidHandler?
    var showAlert: StringHandler?
    var repository: Repository

    // MARK: - Private property

    private let movieAPIService: MovieAPIServiceProtocol

    // MARK: - Init

    init(repository: Repository) {
        self.repository = repository
        movieAPIService = MovieAPIService()
        setRequest()
    }

    // MARK: - Private methods

    private func setRequest() {
        let baseFilms = repository.get(type: ResultsFilm.self, column: nil, filmNumber: nil)

        var movies: [ResultsFilm]?
        baseFilms?.forEach { movie in
            (movies?.append(movie)) ?? (movies = [movie])
        }
        films = movies ?? []

        if films == [] {
            movieAPIService.parsingFilms { [weak self] result in
                switch result {
                case let .failure(error):
                    guard let showAlert = self?.showAlert else { return }
                    DispatchQueue.main.async {
                        showAlert(error.localizedDescription)
                    }
                case let .success(films):
                    guard let films = films else { return }

                    self?.films = films.results
                    DispatchQueue.main.async {
                        let movies = films.results
                        self?.repository.save(object: movies)
                        self?.reloadData?()
                    }
                }
            }
        }
    }
}
