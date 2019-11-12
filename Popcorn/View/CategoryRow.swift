//
//  CategoryRow.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/11/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import UIKit

class CategoryRow: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "movieCell"
    var nowPlayingMovies: [Movie]? = nil {
        didSet {
            collectionView.reloadData()
        }
    }
    var popularMovies: [Movie]? = nil {
        didSet {
            collectionView.reloadData()
        }
    }
}

extension CategoryRow : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return nowPlayingMovies?.count ?? 0
        case 1:
            return popularMovies?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! MovieCell
        switch indexPath.section {
        case 0:
            cell.movie = nowPlayingMovies?[indexPath.row]
        case 1:
            cell.movie = popularMovies?[indexPath.row]
        default:
            cell.movie = Movie(title: "foo", description: "foo", imageUrl: "foo")
        }
        return cell
    }
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hardCodedPadding:CGFloat = 5
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        let itemWidth = itemHeight * 300 / 444
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
