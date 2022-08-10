//
//  AppCoordinator.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 5.05.2022.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DishesViewController.instantiate()
       // vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goFoodDetail(image: String) {
        let foodVC = FoodDetailController.instantiate()
        foodVC.imageName.accept(image)
        navigationController.pushViewController(foodVC, animated: true)
    }
    
    func goPagination(_ userId: Int) {
        let paginationVC = PaginationViewController.instantiate()
        paginationVC.id = userId
        navigationController.pushViewController(paginationVC, animated: true)
    }
    
    func getUserCoordinator() {
        let child = UserCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // ESKI
    // ----------------------------
    
    // Coordinator pattern ile burada window nesnesi oluşturup SceneDelegate'te buradan instance üretip start metodunu çalıştırıyoruz. Start metodunda da ilgili controlleri yapıyoruz. Burada navigation için metodlar oluşturup merkezi bir navigation yapısı kurabiliriz. Storyboard ile projenin başlamasını kaldırmak için info.plist'te arama storyboard yazıp tüm satırları sil.
  //  private let window: UIWindow
    
  /*  init(window: UIWindow) {
        self.window = window
    }*/
    
    
    
  /*  func start() {
        // Bu şekilde vc'yi initialize edersek programmatic olarak başlatırız.
        let viewController = ViewController()
        
        // Eğer bu şekilde initialize edersek storyboard'dan başlatırız ve orada belirttiğimiz kurallar geçerli olur. VC'de instantiate metodunda vc'yi storyboard'dan initialize ediyoruz.
        let viewController2 = UserController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController2)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }*/
}
