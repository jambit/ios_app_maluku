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

struct FoosballTable {
    var name: String
    var backgroundColor: UIColor
    var notOccupiedImage: UIImage?
    var occupiedImage: UIImage?
    

    init(name: String, backgroundColor: UIColor, notOccupiedImage: UIImage?, occupiedImage: UIImage?) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.notOccupiedImage = notOccupiedImage
        self.occupiedImage = occupiedImage
    }
}

