//
//  UserCoordinator.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.06.2022.
//

import Foundation
import UIKit

class UserCoordinator : Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Start metodunda BuyVC'yi initialize ediyoruz.
    func start() {
        let vc = UserController.instantiate()
        vc.viewModel = DIContainer.shared.resolve()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
