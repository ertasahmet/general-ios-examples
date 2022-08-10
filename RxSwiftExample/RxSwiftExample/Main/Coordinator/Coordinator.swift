//
//  Coordinator.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set}
    var navigationController: UINavigationController { get set}
    
    func start()
}
