// MoviesTests.swift
// Copyright © DmitrievSY. All rights reserved.

@testable import Movies
import XCTest
/// tests
class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

/// MoviesTests
class MoviesTests: XCTestCase {
    var navigationController = MockNavigationController()
    var filmsCoordinator: FilmsCoordinator?

    override func setUpWithError() throws {
        filmsCoordinator = FilmsCoordinator(rootController: navigationController)
    }

    override func tearDownWithError() throws {}

    func testFilms() throws {
        filmsCoordinator?.start()
        let filmsController = navigationController.presentedVC
        XCTAssertTrue(filmsController is FilmsTableViewController)
    }

    func testDetails() throws {
        guard let filmsVC = navigationController.presentedVC as? FilmsTableViewController else { return }
        filmsVC.toDetails?(1)
        let filmsController = navigationController.presentedVC
        XCTAssertTrue(filmsController is FilmsTableViewController)
    }
}
