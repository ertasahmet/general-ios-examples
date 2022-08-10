//
//  FoodDetailController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 5.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class FoodDetailController: UIViewController, Storyboarded {

    weak var coordinator: AppCoordinator?
    @IBOutlet weak var imgFood: UIImageView!
    
    // Burada imageName için bir behaviorRelay tuttuk ve default value olarak boş string verdik.
    let imageName: BehaviorRelay = BehaviorRelay<String>(value: "")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad() 

        // ImageName stringine map olarak giriyoruz, name in diye stringi alıyoruz ve bir UIImage nesnesine dönüştürüyoruz. Daha sonra elimizde bir image oluyor, bunu da bind diyerek imgFood iamgeview'ının image property'sien atıyoruz.
        imageName.map { name in
            UIImage(named: name)
        }
        .bind(to: imgFood.rx.image)
        .disposed(by: disposeBag)
        
    }

}
