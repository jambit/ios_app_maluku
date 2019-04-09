//
//  Services.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 15.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Alamofire
import Foundation


class UserService {
    static let shared = UserService()

    private enum URL {
        static let get = "http://kicker.jambit.com/api/user-liste/users"
        static let post = "http://kicker.jambit.com/api/user-liste/add-user?user="
        static let delete = "http://kicker.jambit.com/api/user-liste/delete-user"
    }

    private let utilityQueue = DispatchQueue.global(qos: .utility)

    private init() {}

    func getUserInfo(completionHandler: @escaping ([User]) -> Void) {
        Alamofire.request(URL.get).responseJSON(queue: utilityQueue) { [weak self] response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    guard let userInfo = self?.parseUserInfo(json: response.data) else { return completionHandler([]) }
                    completionHandler(userInfo)
                    return
                }
            case .failure(let error):
                print(error)
                completionHandler([])
            }
        }
    }

    private func parseUserInfo(json: Data?) -> [User]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let data = json, let jsonUserInfo = try? decoder.decode([User].self, from: data) {
            return jsonUserInfo
        }
        return nil
    }

    func addUser(nameOfUser: String) {
        guard let name = nameOfUser.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        let addUrl = URL.post + name
        Alamofire.request(addUrl, method: .post)
    }

    func deleteUser(user: User?) {
        guard let user = user else { return }
        let jsonEncoder = JSONEncoder()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        guard let jsonData = try? jsonEncoder.encode(user) else { return }
        do {
            let params = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            Alamofire.request(URL.delete, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers)
        } catch {
            print(error)
        }
    }
}
