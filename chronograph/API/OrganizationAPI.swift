//
//  OrganizationAPI.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 30/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Alamofire
import Combine

class OrganizationApi {
    let credentials: Credentials

    init(credentials: Credentials) {
        self.credentials = credentials
    }

    func list() -> AnyPublisher<Result<[Organization], AFError>, Never> {
        let headers: HTTPHeaders = [.authorization(bearerToken: self.credentials.token)]

        return AF.request(Config.organizationsURL(), headers: headers)
            .publishDecodable(type: [Organization].self)
            .result()
    }
}
