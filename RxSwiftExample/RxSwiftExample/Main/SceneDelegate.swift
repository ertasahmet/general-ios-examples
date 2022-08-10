//
//  SceneDelegate.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 5.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navController)
        appCoordinator?.start()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        // ESKI
        // ------------------
      /*  let window = UIWindow(windowScene: scene)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()*/
    }
    
    // Deeplink'ten gelen url'leri burada handle ediyoruz.
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        // Önce url'i alıyoruz.
        var userId = 0
        guard let url = URLContexts.first?.url else {
            return
        }
        
        // Host'u kontrol ediyoruz. Host dediğimiz ahmetabi://users kısmındaki users anlamına geliyor.
        guard let host = url.host else { return }
        
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // Burada parametreleri handle edebiliyoruz.
        if let components = components {
            guard let params = components.queryItems else {
                // Host'u deeplink enum'ına çeviriyoruz ve handle ediyoruz.
                if let deepLink = DeepLink(rawValue: host) {
                    handleDeepLink(deepLink, userId)
                }
                return
            }
            
            if let id = params.first(where: { $0.name == "id" })?.value {
                userId = Int(id) ?? 0
                // Host'u deeplink enum'ına çeviriyoruz ve handle ediyoruz.
                if let deepLink = DeepLink(rawValue: host) {
                    handleDeepLink(deepLink, userId)
                }
                print("id = \(id)")
            }
        }
      
    }
    
    // Burada path'e bakıp ona göre sayfaya yönlendiriyoruz.
    func handleDeepLink(_ deepLink: DeepLink, _ userId: Int) {
        switch deepLink {
        case .pagination:
            appCoordinator?.goPagination(userId)
        case .user:
            appCoordinator?.getUserCoordinator()
        case .food:
            appCoordinator?.goFoodDetail(image: "pizza")
        }
    
        
    }

}

