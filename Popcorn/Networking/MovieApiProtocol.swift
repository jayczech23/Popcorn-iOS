//
//  MovieApiProtocol.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/10/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import Foundation

protocol MovieApiProtocol {
    var baseUrl: String { get }
    var imageUrlPrefix: String { get }
    func getLatestMovie(_ completion:@escaping (_ movie: [Movie?]) -> Void)
    func getNowPlaying(_ completion:@escaping (_ movies: [Movie?]) -> Void)
    func getPopular(_ completion:@escaping (_ movies: [Movie?]) -> Void)
    func getConfigurationUrl(_ completion:@escaping ((String) -> Void))
    func getLatestEndpoint() -> String
    func getNowPlayingEndpoint() -> String
    func getPopularEndpoint() -> String
    func getConfigEndpoint() -> String
}
