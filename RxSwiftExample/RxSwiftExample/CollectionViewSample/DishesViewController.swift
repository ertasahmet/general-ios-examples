//
//  DishesViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 14.07.2022.
//

import UIKit
import CardViews

class DishesViewController: UIViewController, Storyboarded {

    @IBOutlet weak var dishesCollectionView: UICollectionView!
    var imageView: CaptionableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupCaptionableImageView()
    }
    
    // Horizontal collection view yapıyoruz. Cell ve collection view'ın clip to bounds property'lerini false yapıyoruz. Collection view'ın type'ını horizontal yapıyoruz.
    private func setupViews() {
        dishesCollectionView.dataSource = self
        dishesCollectionView.delegate = self
        
        // Nib dosyasından cell'i register ettik.
        let nib = UINib(nibName: DishesCollectionViewCell.identifier, bundle: nil)
        dishesCollectionView.register(nib, forCellWithReuseIdentifier: DishesCollectionViewCell.identifier)
        
        // Background transparent yaptık.
        dishesCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    private func setupCaptionableImageView() {
        imageView = CaptionableImageView(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: 200))
        imageView.image = UIImage(named: "blindspot")
        imageView.caption = "Yo yo, I am Ahmet, I'm gonna beat you."
        view.addSubview(imageView)
    }
    
}

extension DishesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesCollectionViewCell.identifier, for: indexPath) as! DishesCollectionViewCell
        
        let dish = dishes[indexPath.row]
        cell.setup(with: dish)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dishes[indexPath.row]
        
        print(item.title)
    }
    
    
    
}
