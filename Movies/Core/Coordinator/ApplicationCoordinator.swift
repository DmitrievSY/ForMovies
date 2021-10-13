// ApplicationCoordinator.swift
// Copyright © RM. All rights reserved.

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    override func start() {
        toMain()
    }

    private func toMain() {
        let coordinator = MainCoordinator()

        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
