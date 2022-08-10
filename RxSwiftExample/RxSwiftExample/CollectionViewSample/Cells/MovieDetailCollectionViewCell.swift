//
//  MovieDetailCollectionViewCell.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 14.07.2022.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    // Bu şekilde cell'de identifier tanımlayarak string yazmaktan kurtulabiliriz.
    static let identifier = String(describing: MovieDetailCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // Burada cell'i ayarladık.
    func setup(with movie: Movie) {
        movieTitle.text = movie.title
        movieImage.image = movie.image
    }

}
