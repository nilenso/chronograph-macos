//
//  Users.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 10/09/20.

//
import Alamofire
import Combine

class UserAPI {
    let credentials: Credentials

    init(credentials: Credentials) {
        self.credentials = credentials
    }

    func me() -> AnyPublisher<Result<User, AFError>, Never> {
        let headers: HTTPHeaders = [.authorization(bearerToken: self.credentials.token)]

        return AF.request(Config.userInfoURL(), headers: headers)
            .publishDecodable(type: User.self)
            .result()
    }
}
