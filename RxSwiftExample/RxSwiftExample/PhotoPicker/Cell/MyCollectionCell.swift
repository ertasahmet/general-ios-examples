//
//  MyCell.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 20.07.2022.
//

import UIKit

class MyCollectionCell: UICollectionViewCell {
    
    public let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
