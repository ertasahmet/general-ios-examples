//
//  MainTabBarController.swift
//  AdvancedCoordinatorPatternSample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // TabBar ile beraber hem coordinator hem de navigationController kullanmak için bu şekilde önce AppCoordinator'ı initialize ediyoruz.
    let main = AppCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Sonra coordinator dan start deyip main vc'yi açıyoruz.
        main.start()
        
        // tabBar'ın controller'larına da appCoordinator'ın navigationController'ını veriyoruz.
        viewControllers = [main.navigationController]
    }

}
