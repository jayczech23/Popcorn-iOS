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
    var latestMovie: Movie!
    var categories = ["Now Playing", "Popular"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var latestMoviePosterImage: UIImageView!
    @IBOutlet weak var latestMovieTitle: UILabel!
    @IBOutlet weak var latestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = MovieApi()
        populateLatestMovie()
        configureUi()
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
        print("Table view section: \(indexPath.section)")
        if indexPath.section == 0 {
            api.getNowPlaying { (movies) in
                cell.movies = movies as! [Movie]
            }
        } else {
            api.getPopular { (movies) in
                cell.movies = movies as! [Movie]
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieCell = sender as? MovieCell,
        let movieDetailVC = segue.destination as? MovieDetailVC {
            let movie = movieCell.movie
            movieDetailVC.movie = movie
        } else {
            // latest movie
            if let movieDetailVC = segue.destination as? MovieDetailVC {
                movieDetailVC.movie = latestMovie
            }
        }
    }
    
    func populateLatestMovie() {
        api.getLatestMovie() { (latest) in
            if let movie = latest[0] {
                if movie.imageUrl.isEmpty {
                    self.latestMoviePosterImage.image = UIImage(named: "popcorn")
                    self.latestMovieTitle.isHidden = false
                    self.latestMovieTitle.text = movie.title
                } else {
                    let url = URL(string: movie.imageUrl)
                    self.latestMoviePosterImage.kf.setImage(with: url)
                }
                self.latestMovie = Movie(title: movie.title,
                                         description: movie.description,
                                         imageUrl: movie.imageUrl)
            }
        }
    }
    
    func configureUi() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        latestView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let segueId = "showMovieDetailSegue"
        performSegue(withIdentifier: segueId, sender: self)
    }
}
