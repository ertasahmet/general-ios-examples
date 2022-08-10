//
//  Sample2ViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.05.2022.
//

import SnapKit

class Sample2ViewController: UIViewController {

    lazy var yellowBox = UIView()
    lazy var greenBox = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
        runSnapKitAutoLayout()
    }
    
    private func setupViews() {
        self.view.addSubview(yellowBox)
        self.view.addSubview(greenBox)
        setupYellowBox()
    }
    
    private func runSnapKitAutoLayout() {
        yellowBox.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.center.equalTo(view.snp.center)
        }
        
        greenBox.snp.makeConstraints { make in
            make.width.equalTo(yellowBox.snp.width).multipliedBy(0.5)
            make.height.equalTo(greenBox.snp.width)
            make.center.equalTo(yellowBox.snp.center)
        }
    }
    
    private func setupYellowBox() {
        yellowBox.backgroundColor = .orange
        yellowBox.layer.cornerRadius = 40
        yellowBox.layer.masksToBounds = true
        yellowBox.layer.borderWidth = 2
        yellowBox.layer.borderColor = UIColor.blue.cgColor
        setupGestures()
        
        greenBox.backgroundColor = .green
        greenBox.layer.cornerRadius = 20
        greenBox.layer.masksToBounds = true
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(boxDidTap))
        yellowBox.addGestureRecognizer(tapGesture)
    }
    
    @objc private func boxDidTap() {
        print("did tapp")

        self.yellowBox.snp.updateConstraints { make in
               make.width.equalTo(280)
               make.height.equalTo(280)
          
           }
    }

}
