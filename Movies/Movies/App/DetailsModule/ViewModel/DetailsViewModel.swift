// DetailsViewModel.swift
// Copyright © DmitrievSY. All rights reserved.

import RealmSwift
import UIKit

protocol DetailsViewModelProtocol {
    var filmDescription: FilmDescription? { get set }
    var reloadData: (() -> ())? { get set }
    var repository: RealmRepository? { get set }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Internal property

    var repository: RealmRepository?
    var reloadData: VoidHandler?
    var filmDescription: FilmDescription?
    let movieAPIService: MovieAPIServiceProtocol

    // MARK: - Private property

    private let filmNumber: Int

    // MARK: - Init

    init(filmNumber: Int, repository: RealmRepository) {
        self.repository = repository
        self.filmNumber = filmNumber
        movieAPIService = MovieAPIService()
        setRequest()
    }

    // MARK: - Private method

    private func setRequest() {
        requestFromDB()
        if filmDescription == nil {
            requestFromNet()
        }
    }

    private func requestFromDB() {
        let filmDescriptionRealm = repository?.get(
            type: FilmDescription.self,
            column: "filmNumber",
            filmNumber: filmNumber
        )
        var detail: FilmDescription?
        filmDescriptionRealm?.forEach { details in
            detail = details
        }
        filmDescription = detail
    }

    private func requestFromNet() {
        movieAPIService.parsingDescription(filmNumber: filmNumber, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error.localizedDescription)
            case let .success(filmDescription):
                filmDescription.filmNumber = String(self?.filmNumber ?? 0)

                DispatchQueue.main.async {
                    self?.repository?.save(object: [filmDescription])
                    self?.requestFromDB()
                    self?.reloadData?()
                }
            }
        })
    }
}
