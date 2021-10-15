// Assembly.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol AssemblyProtocol {
    func createFilmsModule() -> UIViewController
    func createDetailsModule(filmNumber: Int) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    // MARK: - Internal methods

    func createFilmsModule() -> UIViewController {
        let repository = RealmRepository()
        let filmsViewModel = FilmsViewModel(repository: repository)
        let filmsView = FilmsTableViewController(viewModel: filmsViewModel)
        return filmsView
    }

    func createDetailsModule(filmNumber: Int) -> UIViewController {
        let repository = RealmRepository()
        let detailsViewScreen = FilmDescriptionTableViewController()
        let detailsViewModel = DetailsViewModel(filmNumber: filmNumber, repository: repository)
        detailsViewScreen.viewModel = detailsViewModel
        return detailsViewScreen
    }
}
