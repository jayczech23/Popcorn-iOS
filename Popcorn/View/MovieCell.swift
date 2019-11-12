//
//  MovieCell.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/11/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var movie: Movie? = nil {
        didSet  {
            if let movie = movie {
                let url = URL(string: movie.imageUrl)
                self.imageView.kf.setImage(with: url)
            }
        }
    }
}
