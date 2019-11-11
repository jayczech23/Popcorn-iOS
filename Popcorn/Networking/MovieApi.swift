//
//  MovieApi.swift
//  Popcorn
//
//  Created by Cech, Jordan on 11/10/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MovieApi : MovieApiProtocol {
    let baseUrl: String = "https://api.themoviedb.org/3/movie/"
    
    func getNowPlaying(_ completion: @escaping ([Movie?]) -> Void) {
        makeRequest(getNowPlayingEndpoint(), completion)
    }
    
    func getLatestMovie(_ completion: @escaping ([Movie?]) -> Void) {
        makeRequest(getLatestEndpoint(), completion)
    }
    
    func getPopular(_ completion: @escaping ([Movie?]) -> Void) {
        makeRequest(getPopularEndpoint(), completion)
    }
    
    func getLatestEndpoint() -> String {
        return "\(baseUrl)latest?api_key=\(getApiKey())&language=en-US"
    }
    
    func getNowPlayingEndpoint() -> String {
        return "\(baseUrl)now_playing?api_key=\(getApiKey())&language=en-US&page=1"
    }
    
    func getPopularEndpoint() -> String {
        return "\(baseUrl)popular?api_key=\(getApiKey())&language=en-US&page=1"
    }
    
    private func makeRequest(_ endpoint: String, _ completion: @escaping ([Movie?]) -> Void) {
        var resultArr = [Movie]()
        AF.request(endpoint).validate().responseJSON { (response) in
            do {
                if let data = response.data {
                    let json = try JSON(data: data)
                    if json["results"].exists() {
                        for object in json["results"].arrayValue {
                            resultArr.append(self.populateMovieObject(jsonObject: object))
                        }
                    } else {
                        resultArr.append(self.populateMovieObject(jsonObject: json))
                    }
                    completion(resultArr)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func populateMovieObject(jsonObject: JSON) -> Movie {
        let title = jsonObject[TITLE_KEY].stringValue
        let desc = jsonObject[DESCRIPTION_KEY].stringValue
        let imageUrl = "foo"
        return Movie(title: title, description: desc, imageUrl: imageUrl)
    }
    
    func getApiKey() -> String {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        let apiKey = dict!.object(forKey: API_KEY) as! String
        
        return apiKey
    }
}
