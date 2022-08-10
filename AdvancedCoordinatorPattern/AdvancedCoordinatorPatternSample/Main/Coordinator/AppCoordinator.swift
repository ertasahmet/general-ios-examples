//
//  AppCoordinator.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 5.05.2022.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    // Child Coordinator'leri ile beraber AppCoordinator oluşturduk.
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Burada main controller'ı initialize ediyoruz ve navigationController delegate'ini set ediyoruz. Tabbar kullanıyorsak bu vc'ye tabbarItem ataması yapıyoruz.
    func start() {
        navigationController.delegate = self
        let vc = ViewController.instantiate()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    // Büyük projelerde birden fazla coordinator class'ı kullanılabilir. Main Controller'da buyVC'ye gidiyor isek buradaki buy metodunda Buy Coordinator'ı initialize ederiz ve parentCoordinator'ına AppCoordinator atıyoruz ve child'lara ekliyoruz ve start veriyoruz. Oradaki start metodunda da buyVC initialize edilecek.
    func buy() {
        let child = BuyCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // Backstack yapısını iyi yönetmek için child'ları dizide tutuyoruz. NavigationController'da herhangi bir sayfa geçişi olduğunda bu metodu tetikliyoruz ve child'lardan siliyoruz. Mesela Main VC'den buyVC'ye geçtik, daha sonra buyVC'den de başka biryere geçtiysek buyVC'yi child'lardan kaldırıyoruz.
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension AppCoordinator : UINavigationControllerDelegate {
    
    // Bu metodda child stack yapısını yönetiyoruz. Bir sayfadan geçiş yapıldıysa fromVC'yi child'lardan kaldırıyoruz.
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Eğer bu navigation controller'dan gitmiyorsa geçiyoruz.
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        
        // Pop-up şeklinde çıkmadıysa da geçiyoruz.
        if navigationController.viewControllers.contains(fromVC) {return}
        
        // Buraya geldiyse fromVC doludur. Eğer fromVC BuyVC ise yani buyViewController'dan biyere gidildiyse child'i kaldır diyoruz.
        if let buyVC = fromVC as? BuyViewController {
            childDidFinish(buyVC.coordinator)
        }
    }
    
}
