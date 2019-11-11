//
//  Movie.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/10/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import Foundation

class Movie : MovieProtocol  {
    internal var title = ""
    internal var description = ""
    internal var imageUrl = ""
    
    enum Classification {
        case Latest
        case NowPlaying
        case Popular
    }
    
    init(title: String,
         description: String,
         imageUrl: String) {
        
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
}
