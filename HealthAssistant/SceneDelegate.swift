//
//  SceneDelegate.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController = UINavigationController(rootViewController: TabbarController())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = self.navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.window?.makeKeyAndVisible()
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

