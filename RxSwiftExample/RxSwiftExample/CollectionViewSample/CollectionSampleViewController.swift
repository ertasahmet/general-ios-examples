//
//  CollectionSampleViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 14.07.2022.
//

import UIKit

class CollectionSampleViewController: UIViewController, Storyboarded {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleCollectionView()
        
    }
    
    // Collection view'ı initialize ettik.
    private func handleCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Nib dosyasından cell'i register ettik.
        let cellNib = UINib(nibName: MovieDetailCollectionViewCell.identifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: MovieDetailCollectionViewCell.identifier)
    }

}

extension CollectionSampleViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Cell'i ayarlıyoruz.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCollectionViewCell.identifier, for: indexPath) as! MovieDetailCollectionViewCell
        let movie = movies[indexPath.row]
        cell.setup(with: movie)
        
        return cell
    }
    
}

extension CollectionSampleViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        print(movie.title)
    }
}

extension CollectionSampleViewController : UICollectionViewDelegateFlowLayout {
    
    // Burada boyutunu ayarlıyoruz.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
}
