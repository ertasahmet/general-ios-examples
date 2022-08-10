//
//  SceneDelegate.swift
//  AdvancedCoordinatorPatternSample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        // Burada coordinator'ı initialize ettik.
     /*   let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navController)
        appCoordinator?.start()*/
        
        // Tabbar kullanıyorsak bu şekilde window'u Tabbar'dan initialize ediyoruz.
        window = UIWindow(windowScene: scene)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }

}

