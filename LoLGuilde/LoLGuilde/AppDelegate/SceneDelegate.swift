//
//  SceneDelegate.swift
//  LoLGuilde
//
//  Created by Bang on 20/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        return (scene?.delegate as? SceneDelegate)!
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        //code...
        let vc = HomeViewController()
        window.rootViewController = vc
//        let navi = BaseNavigationController(rootViewController: vc)
//        window.rootViewController = navi
        
        self.window = window
        window.makeKeyAndVisible()
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

