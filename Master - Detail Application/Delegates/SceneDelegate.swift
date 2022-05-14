//
//  SceneDelegate.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//

import UIKit

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window : UIWindow?
    func scene(_ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            if let windowScene = scene as? UIWindowScene {
                self.window = UIWindow(windowScene: windowScene)
                let vc = HomeViewController()
                self.window!.rootViewController = vc
                self.window!.makeKeyAndVisible()
                self.window!.backgroundColor = .red
            }
    }
}

