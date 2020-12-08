//
//  Model.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 30/09/20.

//

import CoreData

protocol Model: Codable {
    associatedtype CoreDataModel: NSManagedObject

    init(data: CoreDataModel)

    func dictionary() -> [String: Any]

    static func batchInsert(context: NSManagedObjectContext, objects: [Self]) throws -> Bool
}

extension Model {
    static func removeAll(context: NSManagedObjectContext, objects: [Self]) throws -> Bool {
        guard let entityName = CoreDataModel.entity().name else {
            return false
        }

        let request = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: entityName))

        let result = try context.execute(request) as? NSBatchInsertResult
        return result?.result != nil
    }

    static func batchInsert(context: NSManagedObjectContext, objects: [Self]) throws -> Bool {
        let request = NSBatchInsertRequest(
            entity: CoreDataModel.entity(),
            objects: objects.map({ $0.dictionary() })
        )
        let result = try context.execute(request) as? NSBatchInsertResult
        return result?.result != nil
    }
}
