//
//  ListViewModel.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 23.03.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Foundation

class ListViewModel {
    var users: [User] {
        return UserManager.shared.users
    }

    var cellID: String {
        return "CustomListTableViewCell"
    }

    var addButtonTitle: String {
        return "Eintragen".uppercased()
    }

    var userReserved: Bool {
        return UserManager.shared.userReserved
    }

    var savedUser: String? {
        return UserManager.shared.savedUser
    }

    var returnButtonTitle: String {
        return "Fertig".uppercased()
    }
    
}
