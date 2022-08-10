//
//  BuyCoordinator.swift
//  AdvancedCoordinatorPatternSample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import UIKit

// BuyVC açıldığında artık coordinator görevini burası yürütüyor. BuyVC için navigation işlemlerini burada yapıyoruz.
class BuyCoordinator : Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Start metodunda BuyVC'yi initialize ediyoruz.
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
