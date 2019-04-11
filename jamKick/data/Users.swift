//
//  Users.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 15.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    var name: String
    var id: String
    var room: String?
}
