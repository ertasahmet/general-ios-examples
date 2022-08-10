//
//  LoginTextField.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.05.2022.
//

import Foundation
import UIKit

class CustomLoginView : UIView {
    
    var floatingText : String = "" {
        didSet {
            self.floatingLabel.text = floatingText
        }
    }
    
    var placeHolder: String = "" {
        didSet {
          self.textField.placeholder = placeHolder
        }
    }

    var leftViewColor: UIColor = UIColor.init(red: 138 / 255, green: 15 / 255, blue: 116 / 255, alpha: 1) {
        didSet {
          self.setupProps()
        }
    }

    var leftIcon: UIImage = UIImage(named: "icon_user")! {
        didSet {
            self.setupProps()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupView() {
        self.setupViewParentTextField()
        self.setupFloatingLabel()
        self.setupProps()
    }
    
    func setupProps() {
        self.leftView.backgroundColor = leftViewColor

        self.leftImageView.image = leftIcon
        self.leftImageView.image = self.leftImageView.image?.withRenderingMode(.alwaysTemplate)
        self.leftImageView.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    let floatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 138 / 255, green: 15 / 255, blue: 116 / 255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // Parent View for Input+Icon
    let parentTextField: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    // Left View (Circle Background)
    let leftView: UIView = {
        let view = UIView()

        return view
    }()

    // Left Icon
    let leftImageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

    // TextField
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.none
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    func setupViewParentTextField() {
        self.addSubview(parentTextField)
        parentTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        self.setupLeftView()
    }
    
    func setupLeftView() {
        self.parentTextField.addSubview(self.leftView)
        self.leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(32)
        }
        
        self.leftView.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        self.setupLeftIcon()
        self.setupTextfield()
    }
    
    func setupLeftIcon() {
        self.leftView.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    func setupTextfield() {
        self.parentTextField.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.leading.equalTo(self.leftView.snp.trailing)
                .offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupFloatingLabel() {
        self.addSubview(self.floatingLabel)
        self.floatingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.parentTextField.snp.top).offset(-8)
            make.leading.equalTo(self.parentTextField.snp.leading)
        }
    }
    
}
