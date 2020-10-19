//
//  Organization.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 30/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation

struct Organization: Model {

    typealias CoreDataModel = OrganizationCD

    let id: Int
    let name: String
    let slug: String

    init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }

    init(data: OrganizationCD) {
        self.id = Int(data.id)
        self.name = data.name!
        self.slug = data.slug!
    }

    func dictionary() -> [String: Any] {
        ["id": self.id,
         "name": self.name,
         "slug": self.slug]
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}
