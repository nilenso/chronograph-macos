//
//  User.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 28/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

struct User: Codable {
    var id: Int;
    var name: String;
    var accessToken: String?;
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
