//
//  DishesCollectionViewCell.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 14.07.2022.
//

import UIKit
import Kingfisher

class DishesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dishesImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    static let identifier = String(describing: DishesCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    // Kingfisher kullanımı
    func setup(with dish: Dish) {
        dishesImageView.kf.setImage(with: URL(string: dish.image))
        titleLbl.text = dish.title
        descLbl.text = dish.desc
        caloriesLbl.text = dish.calory
    }
    
    // Bu şekilde UI'da kullanılıyor.
    private func setUI() {
        titleLbl.textColor = UIColor.theme.AccentColor
        descLbl.textColor = UIColor.theme.BackgroundColor
        caloriesLbl.textColor = UIColor.theme.RedColor
    }
    
}
