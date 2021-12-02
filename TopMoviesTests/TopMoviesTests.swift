//
//  TopMoviesTests.swift
//  TopMoviesTests
//
//  Created by Joshua Hoyle on 12/2/21.
//

import XCTest
import TopMovies
@testable import TopMovies

class TopMoviesTests: XCTestCase {
    
    let movie = Movie(title: "Venom: Let There Be Carnage", overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.", poster: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg")
    
    func testFetchMovies() {
       
        MovieController.fetchMovies { result in
            switch result {
            case .success(let movie):
                XCTAssertEqual(movie.count, 1)
                
            case .failure:
                XCTFail()
        }
        }
    }
    
    func testFetchPoster() {
        MovieController.fetchMovies { result in
            switch result {
            case .success(let movie):
                XCTAssertEqual(self.movie.poster, "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg" )
            case . failure:
                XCTFail()
            }
        }
    }
    
    /*

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}
