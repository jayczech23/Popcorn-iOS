//
//  PopcornVC.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/11/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import UIKit
import Kingfisher

class PopcornVC: UIViewController, UITableViewDataSource {
   
    let numSections = 2
    var api: MovieApiProtocol!
    var categories = ["Now Playing", "Popular"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var latestMoviePosterImage: UIImageView!
    @IBOutlet weak var latestMovieTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = MovieApi()
        populateLatestMovie()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        
        switch indexPath.section {
        case 0:
            // now playing
            api.getNowPlaying { (movies) in
                cell.nowPlayingMovies = movies as! [Movie]
            }
        case 1:
            // popular
            api.getPopular { (movies) in
                cell.popularMovies = movies as! [Movie]
            }
        default:
            return cell 
        }
        return cell
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
