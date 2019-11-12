//
//  MovieDetailVC.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/11/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailVC: UIViewController {
    
    var movie: Movie?

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    func configureUi() {
        if let movie = self.movie {
            movieTitle.text = movie.title
            movieOverview.text = movie.description
            movieGenre.text = "genre"
            if movie.imageUrl.isEmpty {
                movieImage.image = UIImage(named: "popcorn")
                return
            }
            let url = URL(string: movie.imageUrl)
            movieImage.kf.setImage(with: url)
        }
    }
}
