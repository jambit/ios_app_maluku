//
//  UserManager.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 23.03.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Foundation

enum Key {
    static let userName = "savedUserName"
    static let isUserReserved = "isUserReserved"
}

class UserManager {
    private var userInfo: [User]?
    static let shared = UserManager()
    private let userDefaults: UserDefaults
    private init () {
        userDefaults = UserDefaults.standard
    }

    func deleteUser() {
        if userReserved {
            let user = users.first(where: { $0.name == savedUser })
            UserService.shared.deleteUser(user: user)
            removeUserSettings()
        }
    }

    func addUser(_ userName: String) {
            UserService.shared.addUser(nameOfUser: userName)
            userReserved = true
            savedUser = userName
    }

    func removeUserSettings() {
        userReserved = false
        userDefaults.removeObject(forKey: Key.userName)
    }
    func saveUserSettings(_ user: String?) {
        guard let userName = user else { return }
        UserManager.shared.addUser(userName)
    }

    var users: [User] {
        UserService.shared.getUserInfo(completionHandler: { [weak self] users in
            self?.userInfo = users
        })
        guard let users = userInfo else { return [] }
        return users
    }

    var userReserved: Bool {
        get {
            return userDefaults.bool(forKey: Key.isUserReserved)
        }
        set {
            userDefaults.set(newValue, forKey: Key.isUserReserved)
        }
    }

    var savedUser: String? {
        get {
            return userDefaults.string(forKey: Key.userName)
        }
        set {
            userDefaults.set(newValue, forKey: Key.userName)
        }
    }

}
