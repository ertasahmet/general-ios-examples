//
//  ViewController.swift
//  AdvancedCoordinatorPatternSample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buySubscription()
    }
    
    func buySubscription() {
        coordinator?.buy()
    }


}

