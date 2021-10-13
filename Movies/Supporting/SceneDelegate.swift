// SceneDelegate.swift
// Copyright © RM. All rights reserved.

import UIKit

/// сцен делегат
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let assemble = Assemble()
        let filmsModule = assemble.createFilmsModule()

        let navController = UINavigationController(rootViewController: filmsModule)

        navController.navigationBar.prefersLargeTitles = true

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
