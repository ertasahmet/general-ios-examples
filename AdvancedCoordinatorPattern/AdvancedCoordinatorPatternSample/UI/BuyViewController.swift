//
//  BuyViewController.swift
//  AdvancedCoordinatorPatternSample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import UIKit

class BuyViewController: UIViewController, Storyboarded {

    // BuyVC'de buyCoordinator ile işlem yapıyoruz. O da AppCoordinator'ın child'ı.
    weak var coordinator: BuyCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
