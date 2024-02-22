//
//  PersistentContainer.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import Foundation
import CoreData

class PersistentContainer {
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cookbook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
                return
            }
        })
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        return container
    }()
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CookbookImage")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let batchDelete = try container.viewContext.execute(deleteRequest) as? NSBatchDeleteResult
            
            guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }
            
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deleteResult],
                                                into: [container.viewContext])
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
