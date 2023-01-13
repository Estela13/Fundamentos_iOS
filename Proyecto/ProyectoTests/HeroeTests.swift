//
//  HeroeTests.swift
//  ProyectoTests
//
//  Created by Oscar Rodriguez Garrucho on 21/12/22.
//

import XCTest
@testable import Proyecto

final class HeroeTests: XCTestCase {
    
    var heroe: Heroe!

    override func setUp() {
        super.setUp()
        
        heroe = Heroe(id: "4",
                      name: "Goku",
                      photo: "https://www.keepcoding.io",
                      description: "Goku always win!!!",
                      favorite: false)
    }

    override func tearDown() {
        heroe = nil
        super.tearDown()
    }
    
    func testHeroeId() {
        XCTAssertNotNil(heroe.id)
        XCTAssertEqual(heroe.id, "4")
        XCTAssertNotEqual(heroe.id, "7")
    }
    
    func testHeroeName() {
        XCTAssertNotNil(heroe.name)
        XCTAssertEqual(heroe.name, "Goku")
        XCTAssertNotEqual(heroe.name, "Vegeta")
    }
    
    func testHeroePhoto() {
        let url = URL(string: heroe.photo)
        
        XCTAssertNotNil(heroe.photo)
        XCTAssertEqual(heroe.photo, "https://www.keepcoding.io")
        XCTAssertNotEqual(heroe.photo, "https://www.keepcoding.com")
        
        // TODO: - Check this one!
        XCTAssertNotNil(url?.absoluteURL)
    }
    
    func testHeroeDescription() {
        XCTAssertNotNil(heroe.description)
        XCTAssertEqual(heroe.description, "Goku always win!!!")
        XCTAssertNotEqual(heroe.description, "Goku alwaySS win!!!")
    }
    
    func testHeroeFav() {
        XCTAssertNotNil(heroe.favorite)
        XCTAssertEqual(heroe.favorite, false)
    }


}
