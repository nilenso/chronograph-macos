//
//  Users.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 10/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Alamofire
import Combine

class UserAPI {
    let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func me() -> AnyPublisher<Result<User, AFError>, Never> {
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]

        return AF.request(Config.userInfoURL(), headers: headers)
            .publishDecodable(type: User.self)
            .result()
    }
}
