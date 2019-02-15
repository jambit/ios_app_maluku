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
    private let baseUrlGet = "http://azubisrv.jambit.com/api/user-liste/users"
    private let baseUrlPost = "http://azubisrv.jambit.com/api/user-liste/add-user?user="
    private let baseUrlDelete = "http://azubisrv.jambit.com/api/user-liste/delete-user"
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    private init() {}

    func getUserInfo(completionHandler: @escaping ([UserInfo]) -> Void) {
        Alamofire.request(baseUrlGet).responseJSON(queue: utilityQueue) { [weak self] response in
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

    private func parseUserInfo(json: Data?) -> [UserInfo]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let data = json, let jsonUserInfo = try? decoder.decode([UserInfo].self, from: data) {
            return jsonUserInfo
        }
        return nil
    }

    func addUser(nameOfUser: String) {
        guard let name = nameOfUser.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        let addUrl = baseUrlPost + name
        Alamofire.request(addUrl, method: .post)
        let savedUser = nameOfUser
        UserDefaults.standard.set(savedUser, forKey: "savedUser")
    }

    func deleteUSer(user: UserInfo?) {
        guard let user = user else { return }
        let jsonEncoder = JSONEncoder()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        guard let jsonData = try? jsonEncoder.encode(user) else { return }
        do {
            let params = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            Alamofire.request(baseUrlDelete, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers)
        } catch {
            print(error)
        }
    }
}
