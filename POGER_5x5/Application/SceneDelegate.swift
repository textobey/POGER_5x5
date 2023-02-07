//
//  SceneDelegate.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        let trainingViewController = TrainingViewController()
        let navigationController = UINavigationController(rootViewController: trainingViewController)
        window?.rootViewController = navigationController
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 8
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.paragraphStyle: style]
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

