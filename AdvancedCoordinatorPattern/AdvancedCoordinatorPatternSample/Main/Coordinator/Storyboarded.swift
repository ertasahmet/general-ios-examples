//
//  Storyboarded.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 12.05.2022.
//

import Foundation
import UIKit

// Storyboard'dan viewController türetebilmek için bir protocol oluşturduk ve instantiate metodu ile storyboard'dan initialize ediyoruz.
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    // Burada instantiate metodu ile protocol'u implemente ettiğimiz viewController'ı Main storyboard'dan oluşturup dönüyoruz. Storyboard id'si viewController'ın ismi ile aynı olmalı ki ona ulaşabilsin.
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
