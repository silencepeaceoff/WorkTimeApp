//
//  SceneDelegate.swift
//  WorkTimeApp
//
//  Created by Dmitrii Tikhomirov on 4/20/23.
//

import UIKit
import AuthSDK

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = AuthViewController()
        window?.makeKeyAndVisible()
    }
}

