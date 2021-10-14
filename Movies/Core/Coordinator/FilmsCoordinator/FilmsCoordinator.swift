// FilmsCoordinator.swift
// Copyright © RM. All rights reserved.

import Foundation
import UIKit

final class FilmsCoordinator: BaseCoordinator {
    // MARK: - Internal property

    var onFinishFlow: VoidHandler?

    // MARK: - Private property

    private var rootController: UINavigationController?
    private let assembly = Assembly()

    // MARK: - Init

    convenience init(rootController: UINavigationController) {
        self.init()
        self.rootController = rootController
    }

    override func start() {
        showFilmsModule()
    }

    // MARK: - Private methods

    private func showFilmsModule() {
        guard let controller = assembly.createFilmsModule() as? FilmsTableViewController else { return }

        controller.toDetails = { [weak self] filmNumber in
            self?.showFilmDetails(filmNumber: filmNumber)
        }

        if rootController == nil {
            let navController = UINavigationController(rootViewController: controller)
            rootController = navController
            setAsRoot(navController)
        } else if let rootController = rootController {
            rootController.pushViewController(controller, animated: true)
            setAsRoot(rootController)
        }
    }

    private func showFilmDetails(filmNumber: Int) {
        let controller = assembly.createDetailsModule(filmNumber: filmNumber)
        rootController?.pushViewController(controller, animated: true)
    }
}
