//
//  LoginController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 8.05.2022.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginController: UIViewController, Storyboarded {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Textfield'ların textini observable olarak alıyoruz ve orEmpty diyerek boş olup olmadığını kontrol ediyoruz.
        let observable1 = self.txtEmail.rx.text.orEmpty
        let observable2 = self.txtPassword.rx.text.orEmpty
        
        // Burada iki observable nesnesini combine ediyoruz yani ikisi birden tetiklendiğinde bu combined tetiklenecek.
        let observableCombined = Observable.combineLatest(observable1, observable2)
        
        // Butonun üstüne tıklanma durumunu rx.tap diyerek handle ediyoruz. withLatestFrom ile combine edilmiş observable'lara subscribe oluyoruz. Kullanıcı ikisine de yazıp butona bastığında burası tetikleniyor. $0 ve $1 ile combine ettiğimiz observable'ların değerlerini yani email ve password'u login metodumuza veriyoruz.
        self.btnLogin.rx.tap
            .withLatestFrom(observableCombined)
            .subscribe(onNext: {
                self.loginUser(email: $0, pass: $1)
            })
            .disposed(by: disposeBag)
        
    }
    
    // Burada da gerekli işlemleri çalıştırıp login işlemini yapıyoruz.
    func loginUser(email: String, pass: String) {
        if !email.isEmpty && !pass.isEmpty {
            let foodListVC = self.storyboard?.instantiateViewController(withIdentifier: "viewController") as! ViewController
            self.navigationController?.pushViewController(foodListVC, animated: true)
        } else {
            print("error")
        }
    }

}
