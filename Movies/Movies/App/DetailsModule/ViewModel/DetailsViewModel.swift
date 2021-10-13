// DetailsViewModel.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol DetailsViewModelProtocol {
    var filmDescription: FilmDescription? { get set }
    var reloadData: (() -> ())? { get set }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Internal property

    var reloadData: (() -> ())?
    var filmDescription: FilmDescription?
    let movieAPIService: MovieAPIServiceProtocol

    // MARK: - Private property

    private let filmNumber: Int

    // MARK: - Init

    init(filmNumber: Int) {
        self.filmNumber = filmNumber
        movieAPIService = MovieAPIService()
        setRequest()
    }

    // MARK: - Private method

    private func setRequest() {
        movieAPIService.parsingDescription(filmNumber: filmNumber, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error.localizedDescription)
            case let .success(filmDescription):
                self?.filmDescription = filmDescription

                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            }
        })
    }
}
