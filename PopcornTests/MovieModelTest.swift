//
//  MovieModelTest.swift
//  PopcornTests
//
//  Created by Cech, Jordan on 11/10/19.
//  Copyright © 2019 Cech, Jordan. All rights reserved.
//

import XCTest
@testable import Popcorn

class MovieModelTest: XCTestCase {
    
    private var movie: Movie!
    
    override func setUp() {
        movie = Movie(title: "Test", description: "Foo", imageUrl: "Bar", genre: "Action")
    }
    
    func testLatestMovie() {
        assertMovieFields()
    }
    
    func testPopularMovie() {
        assertMovieFields()
    }
    
    func testNowPlayingMovie() {
        assertMovieFields()
    }
    
    private func assertMovieFields() {
        XCTAssertFalse(movie.title.isEmpty)
        XCTAssertFalse(movie.description.isEmpty)
        XCTAssertFalse(movie.imageUrl.isEmpty)
        XCTAssertFalse(movie.genre.isEmpty)
    }
    
}
