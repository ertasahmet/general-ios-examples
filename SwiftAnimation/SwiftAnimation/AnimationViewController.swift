//
//  AnimationViewController.swift
//  SwiftAnimation
//
//  Created by Ahmet Ertas on 21.06.2022.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rotateImage()
            self.animateRadius()
        }
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        guard validateEmail() else {
            shakeField(emailTF)
            return
        }
        
        guard validatePassword() else {
            shakeField(passwordTF)
            return
        }
        
        print("Çokk iyiii. Hepsi başarılııı")
    }
    
    private func shakeField(_ textField: UITextField) {
        
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.08, 0.25, 0.415, 0.5]
        animation.duration = 0.5
        
        // Animasyon bittiğinde olduğu yerde dursun diyoruz.
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        animation.repeatCount = 2
        
        // Burada animasyon kendi view'ında olsun diyoruz ve olduğu yerden itibaren yapıyor.
        animation.isAdditive = true
        
        textField.layer.add(animation, forKey: nil)
        
        // Bu da backgroundColor değiştirmek için.
        let colorKeyframeAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")

        colorKeyframeAnimation.values = [UIColor.red.cgColor,
                                         UIColor.green.cgColor,
                                         UIColor.blue.cgColor]
        colorKeyframeAnimation.keyTimes = [0, 0.5, 1]
        colorKeyframeAnimation.duration = 2
        colorKeyframeAnimation.repeatCount = 3
        
        view.layer.add(colorKeyframeAnimation, forKey: nil)
    }
    
    private func validateEmail() -> Bool {
        if emailTF.text?.count ?? 0 > 7 {
            return true
        } else {
            return false
        }
    }
    
    private func validatePassword() -> Bool {
        if passwordTF.text?.count ?? 0 > 7 {
            return true
        } else {
            return false
        }
    }
    
    private func rotateImage() {
        
        // Burada dönme efekti yapıyoruz.
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        // Burada 0 pozisyonundan başlıyoruz
        animation.fromValue = 0
        
        // Yarıçapın 2 katına git diyoruz yani 1 tur dönüyor aslında
        animation.toValue = CGFloat.pi * 2
        
        // 3 saniye sürsün diyoruz.
        animation.duration = 3
        
        // İnfinity dersek sonsuz animasyon yapar.
        animation.repeatDuration = .infinity
        
        // Bunu true dersek tüm yaptığı animasyonu bitince tekrar aynısını tersten yapar.
        animation.autoreverses = true
        
        // Ease in ease out diyerek ilk başta hızlı sona doğru yavaşlıyor.
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // Animasyonu image'a ekliyoruz.
        imageView.layer.add(animation, forKey: "rotation-animation")
    }
    
    // Buradaki animasyonda corner radius ekleyip geri çıkartıyor.
    private func animateRadius() {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 0
        animation.toValue = 150
        animation.duration = 3
        animation.autoreverses = true
        animation.repeatCount = .infinity
        imageView.layer.add(animation, forKey: nil)
    }
    
}
