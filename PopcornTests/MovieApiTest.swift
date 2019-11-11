//
//  MovieApiTest.swift
//  PopcornTests
//
//  Created by Cech, Jordan on 11/10/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import XCTest
@testable import Popcorn

class MovieApiTest: XCTestCase {
    
    var api: MovieApiProtocol!

    override func setUp() {
        api = MovieApi()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetLatestEndpoint() {
        let expected = "https://api.themoviedb.org/3/movie/latest?api_key=\(MovieApi().getApiKey())&language=en-US"
        let result = api.getLatestEndpoint()
        XCTAssertEqual(result, expected)
    }
    
    func testGetNowPlayingEndpoint() {
        let expected = "\(api.baseUrl)now_playing?api_key=\(MovieApi().getApiKey())&language=en-US&page=1"
        let result = api.getNowPlayingEndpoint()
        XCTAssertEqual(result, expected)
    }
    
    func testGetPopularEndpoint() {
        let expected = "\(api.baseUrl)popular?api_key=\(MovieApi().getApiKey())&language=en-US&page=1"
        let result = api.getPopularEndpoint()
        XCTAssertEqual(result, expected)
    }
    
    func testGetLatestMovie() {
        let expect = expectation(description: "Expecting Movie object after Api call")
        api.getLatestMovie { (movies) in
            XCTAssertTrue(movies.count == 1)
            for latest in movies {
                XCTAssertNotNil(latest)
                XCTAssertFalse(latest?.title.isEmpty ?? true)
                XCTAssertFalse(latest?.description.isEmpty ?? true)
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 25) { (error) in
            if error != nil {
                XCTFail("error: \(error!.localizedDescription)")
            }
        }
    }
    
    func testGetNowPlayingMovies() {
        let expect = expectation(description: "Expecting array of moviees after api call")
        api.getNowPlaying { (movies) in
            XCTAssertFalse(movies.count <= 0)
            for movie in movies {
                XCTAssertNotNil(movie)
                XCTAssertFalse(movie?.title.isEmpty ?? true)
                XCTAssertFalse(movie?.description.isEmpty ?? true)
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 20) { (error) in
            if error != nil {
                XCTFail("error: \(error!.localizedDescription)")
            }
        }
    }
    
    func testGetPopularMovies() {
        let expect = expectation(description: "Expecting array of moviees after api call")
        api.getPopular { (movies) in
            XCTAssertFalse(movies.count <= 0)
            for movie in movies {
                XCTAssertNotNil(movie)
                XCTAssertFalse(movie?.title.isEmpty ?? true)
                XCTAssertFalse(movie?.description.isEmpty ?? true)
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 20) { (error) in
            if error != nil {
                XCTFail("error: \(error!.localizedDescription)")
            }
        }
    }
}
