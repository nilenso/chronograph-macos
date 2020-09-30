//
//  Organization.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 30/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation

struct Organization: Codable {
    var id: Int;
    var name: String;
    var slug: String;
    
    private enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}
