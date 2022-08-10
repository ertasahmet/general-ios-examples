//
//  Animation2ViewController.swift
//  SwiftAnimation
//
//  Created by Ahmet Ertas on 22.06.2022.
//

import UIKit

class Animation2ViewController: UIViewController {

    private var boxView: UIView!
    private var animation: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBox()
        setupAnimation()
    }
    
    // Burada UIViewPropertyAnimator tanımladık. Bunun olayı içine yazdığımız şeyleri yapıyor. Animasyon kısmına yazdığımız şeyler animasyonun son hali oluyor.
    private func setupAnimation() {
        animation = UIViewPropertyAnimator(duration: 1,
                                           curve: .easeInOut,
                                           animations: {
            
            // Animasyonun sonunda kutu, yuvarlak olsun diyoruz.
            self.boxView.layer.cornerRadius = self.boxView.frame.width / 2
            
            // Kendi etrafında dönsün diyoruz.
            self.boxView.transform = self.boxView.transform.rotated(by: .pi)
            
            // X konumu tüm view'ın width'inden 100 çıakrıp olsun diyoruz. Mesela width 500, 100 çıkarınca 400 oluyor. Yani ekranın sonu oluyor.
            self.boxView.frame.origin.x = self.view.frame.width - 110
            
            // Ekranın background color'ı da blue olsun diyoruz.
            self.view.backgroundColor = .blue
        })
    }
    
    // Burada kutuyu tanımladık.
    private func setupBox() {
        boxView = UIView(frame: CGRect(x: 10,
                                       y: Int(view.center.y) - 100 - 20,
                                       width: 100,
                                       height: 100))
        boxView.backgroundColor = .green
        view.addSubview(boxView)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        // Tüm olay burada aslında. Burada animasyonun progress'ini belirtiyoruz. Yani Slider'dan kaçı seçtiysek mesela kaydırdık 0.5 oldu o zaman animasyon son halinin yarısında olmuş oluyor. Burada değer 0 ile 1 arasında olmak zorunda.
        animation.fractionComplete = CGFloat(sender.value)
    }
    
}
