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
    let accessToken: String;
    
    init(accessToken: String) {
        self.accessToken = accessToken;
    }
    
    func list() -> AnyPublisher<Result<[Organization], AFError>, Never>{
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]
        
        return AF.request(Config.organizationsURL(), headers: headers)
            .publishDecodable(type: [Organization].self)
            .result()
    }
}
