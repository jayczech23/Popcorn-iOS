//
//  PopcornVC.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/11/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import UIKit
import Kingfisher

class PopcornVC: UIViewController {
    
    @IBOutlet weak var latestMoviePosterImage: UIImageView!
    
    @IBOutlet weak var latestMovieTitle: UILabel!
    var api: MovieApiProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api = MovieApi()
        populateLatestMovie()
    }
    
    func populateLatestMovie() {
        api.getLatestMovie() { (latest) in
            if let movie = latest[0] {
                if movie.imageUrl.isEmpty {
                    self.latestMovieTitle.text = movie.title
                    self.latestMovieTitle.isHidden = false
                    return
                }
                let url = URL(string: movie.imageUrl)
                self.latestMoviePosterImage.kf.setImage(with: url)
            }
        }
    }
}
