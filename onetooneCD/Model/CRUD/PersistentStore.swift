//
//  PersistentStore.swift
//  onetooneCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation
import CoreData

class PersistentStore{
    
    private init () {}
    
    static let shared = PersistentStore()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "onetooneCD")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError{
                
                fatalError("Unresolved error: \(error), \(error.localizedDescription)")
            }
          
        }
        return persistentContainer
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func save(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let error = error as NSError
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T:NSManagedObject>(managedObject:T.Type)-> [T]?{
        
        do{
            guard let results = try PersistentStore.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            
            return results
            
        }catch let error{
        debugPrint(error)
        }
        return nil
    }
}
