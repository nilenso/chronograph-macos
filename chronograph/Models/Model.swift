//
//  Model.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 30/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import CoreData

protocol Model: Codable {
    associatedtype CoreDataModel: NSManagedObject
    
    init(data: CoreDataModel)
    
    func dictionary() -> [String: Any]
    
    static func batchInsert(context: NSManagedObjectContext, objects: [Self]) throws -> Bool
}

extension Model {
    static func batchInsert(context: NSManagedObjectContext, objects: [Self]) throws -> Bool {
        let request = NSBatchInsertRequest(
            entity: CoreDataModel.entity(),
            objects: objects.map({ $0.dictionary() })
        )
        let result = try context.execute(request) as? NSBatchInsertResult;
        return result?.result != nil
    }
}
