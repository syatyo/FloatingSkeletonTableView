//
//  FloatingSkeletonTableViewTests.swift
//  FloatingSkeletonTableViewTests
//
//  Created by 山田良治 on 2018/12/15.
//  Copyright © 2018 山田良治. All rights reserved.
//

import XCTest
import SwiftyXMLParser
@testable import FloatingSkeletonTableView

class FloatingSkeletonTableViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTranslator() {
        let url = Bundle.main.url(forResource: "movie_data", withExtension: "xml")!
        let data = try! Data(contentsOf: url)
        let xml = XML.parse(data)
        
        let movies = MovieTranslater.translate(from: xml)
        let movie = movies[0]
        
        XCTAssertEqual(movie.thumbnailURL, URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Video118/v4/d0/62/ae/d062ae37-b3d4-63ec-9f3d-2c6c2cb312b2/02482_MLJP_JurassicWorldFallenKingdom_2000x3000.lsr/113x170bb-85.png"))
        XCTAssertEqual(movie.description, "It’s been three years since theme park and luxury resort, Jurassic World was destroyed by dinosaurs out of containment. Isla Nublar now sits abandoned by humans while the surviving dinosaurs fend for themselves in the jungles. When the island’s dormant volcano begins roaring to life, Owen (Chris Pratt) and Claire (Bryce Dallas Howard) mount a campaign to rescue the remaining dinosaurs from this extinction-level event.")
    }
}
