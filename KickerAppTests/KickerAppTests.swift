//
//  KickerAppTests.swift
//  KickerAppTests
//
//  Created by Phuong Nguyen on 23.02.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import XCTest
@testable import KickerApp

class KickerAppTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {
        super.tearDown()
    }

    func testParse() {
        guard let path = Bundle(for: KickerAppTests.self).path(forResource: "FoosballTable", ofType: "json") else {
            XCTFail("Could not find file")
            return
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("Cannot parse json file")
            return
        }
        let viewModel = FoosballTableViewModel()
        let occupiedTables = viewModel.occupiedTables
        XCTAssertEqual(occupiedTables.count, 0)

    }



}
