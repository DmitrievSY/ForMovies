// FilmsCoordinator.swift
// Copyright © RM. All rights reserved.

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator {
    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?
    let assembly = Assembly()

    override func start() {
        showFilmsModule()
    }

    private func showFilmsModule() {
        let controller = assembly.createFilmsModule() as? FilmsTableViewController

        controller?.toDetails = { [weak self] filmNumber in
            self?.showFilmDetails(filmNumber: filmNumber)
        }

        rootController = UINavigationController(rootViewController: controller ?? UIViewController())
        setAsRoot(rootController ?? UIViewController())
    }

    private func showFilmDetails(filmNumber: Int) {
        let controller = assembly.createDetailsModule(filmNumber: filmNumber)
        rootController?.pushViewController(controller, animated: true)
    }
}
