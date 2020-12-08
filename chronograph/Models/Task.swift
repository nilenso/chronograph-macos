//
//  Task.swift
//  chronograph
//
//  Created by Sandilya Jandhyala on 17/11/20.

//

import Foundation

struct Task: Codable {
    let id: Int
    let organizationID: Int
    let name: String
    let description: String!
    let archivedAt: Date!
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case organizationID = "organization-id"
        case archivedAt = "archived-at"
    }
}
