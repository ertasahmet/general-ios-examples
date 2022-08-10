//
//  SnapkitSampleViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 24.05.2022.
//

import UIKit

class SnapkitSampleViewController: UIViewController {

    let customView = CustomLoginView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        setupCustomLoginView()
        setupButton()
    }
    
    private func setupButton() {
        button.backgroundColor = .orange
        button.tintColor = .white
        button.setTitle("Change Constraint", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(customView.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(250)
        }
    }
    
    private func setupCustomLoginView() {
        customView.floatingText = "Username"
        customView.placeHolder = "Enter Username"
        customView.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        self.view.addSubview(customView)
        
        // Offset boşluk bırakmak için kullanılır.
        customView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(100)
        }
    }
    
    @objc func didTapButton() {
        // Constraintleri update etmek için update constraint kullanıyoruz. Remake constraint ise, ilgili view'ın tüm constraintlerini siler. 
        customView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        
        
    }

}
