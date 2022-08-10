//
//  ViewController.swift
//  SwiftAnimation
//
//  Created by Ahmet Ertas on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertViewTopConstraint: NSLayoutConstraint!
    var isActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideAlert()
    }

    
    @IBAction func buttonClicked(_ sender: Any) {
      //  animateAlert(show: !isActive)
        springAnimate(show: !isActive)
    }
    
    private func springAnimate(show: Bool) {
        
        // Aynı animate metodunun farklı parametreli olanı var. Spring, bounce oluyor ve zıplatma efekti veriyor. Velocity ile beraber değerlerde oynarsak güzel bir ayar yapabiliriz. Animasyon tamamlandığında da birşey yaptırmak istersek completion metodunu kullanıyoruz.
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.4,
                       options: [.curveEaseInOut]) { [weak self] in
            if show {
                self?.showAlert()
            } else {
                self?.hideAlert()
            }
            
            self?.view.layoutIfNeeded()
        } completion: { _ in
            print("The animation is complete!")
        }

    }
    
    // Basit animasyon yapımı.
    private func animateAlert(show: Bool) {
        
        // Animate içinde neyin animasyon olacağını yazıyoruz ve ve en son animasyonun çalışması için layoutIfNeeded çalıştırıyoruz.
        UIView.animate(withDuration: 1) { [weak self] in
            if show {
                self?.showAlert()
            } else {
                self?.hideAlert()
            }
            
            self?.view.layoutIfNeeded()
        }
    }
    
    private func showAlert() {
        isActive = true
        alertViewTopConstraint.constant = 20
    }
    
    private func hideAlert() {
        isActive = false
        alertViewTopConstraint.constant = -(alertView.frame.origin.y) - alertView.frame.height
    }
    
}

