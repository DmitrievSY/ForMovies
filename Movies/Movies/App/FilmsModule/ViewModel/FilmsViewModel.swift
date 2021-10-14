// FilmsViewModel.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol FilmsViewModelProtocol {
    var films: Category? { get set }
    var reloadData: VoidHandler? { get set }
    var showAlert: StringHandler? { get set }
}

final class FilmsViewModel: FilmsViewModelProtocol {
    // MARK: - enum

    private enum TextForURL: String {
        case error = "Error serialization json"
    }

    // MARK: - Internal Property

    var films: Category?
    var reloadData: VoidHandler?
    var showAlert: StringHandler?

    // MARK: - Private property

    private let movieAPIService: MovieAPIServiceProtocol

    // MARK: - Init

    init() {
        movieAPIService = MovieAPIService()
        setRequest()
    }

    // MARK: - Private methods

    private func setRequest() {
        movieAPIService.parsingFilms { [weak self] result in
            switch result {
            case let .failure(error):
                guard let showAlert = self?.showAlert else { return }
                DispatchQueue.main.async {
                    showAlert(error.localizedDescription)
                }
            case let .success(films):
                self?.films = films
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            }
        }
    }
}
