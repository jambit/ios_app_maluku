//
//  KickerTische.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 16.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct FoosballTableCodable: Codable {
    var table: Int
    var id: Int
    var occupied: Bool
}

class Table {
    var occupiedPlaces: [Int] = []
    init() {}
}
