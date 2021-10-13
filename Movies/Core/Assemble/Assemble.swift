// Assemble.swift
// Copyright © RM. All rights reserved.

import UIKit

protocol AssembleProtocol {
    func createFilmsModule() -> UIViewController
    func createDetailsModule(filmNumber: Int) -> UIViewController
}

final class Assemble: AssembleProtocol {
    func createFilmsModule() -> UIViewController {
        let filmsViewModel = FilmsViewModel()
        let filmsView = FilmsTableViewController(viewModel: filmsViewModel)
        return filmsView
    }

    func createDetailsModule(filmNumber: Int) -> UIViewController {
        let detailsViewScreen = FilmDescriptionTableViewController()
        let detailsViewModel = DetailsViewModel(filmNumber: filmNumber)
        detailsViewScreen.viewModel = detailsViewModel
        return detailsViewScreen
    }
}
