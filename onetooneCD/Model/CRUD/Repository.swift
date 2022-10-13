//
//  BaseGroup.swift
//  onetooneCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation
import CoreData

protocol BaseGroupRepository{
    associatedtype T
    
    func create(record:T)
    func getAllItems()-> [T]?
    func getItem(byIdentifier id:UUID)->T?
    func delete(byIdentifier id:UUID)->Bool
    func update(record:T)->Bool
}

protocol EmployeeRepository: BaseGroupRepository{
    
    
}

protocol PassportRepository: BaseGroupRepository{
    
}

struct EmployeeDataRepository: EmployeeRepository{
    func create(record: Employee) {
        let employee = CDEmployee(context: PersistentStore.shared.context)
        employee.name = record._name
        employee.id = record.id
        employee.profilePicture = record.profilePicture
        employee.email = record._email

        if record.passport != nil {
            let cdpassport = CDPassport(context: PersistentStore.shared.context)
            cdpassport.id = record.passport?._id
            cdpassport.passportID = record.passport?._passportId
            cdpassport.placeOfIssue = record.passport?._placeOfIssue
            
            employee.toPassport = cdpassport
        }
        
        PersistentStore.shared.save()
    }
    
    func getAllItems() -> [Employee]? {
        let records = PersistentStore.shared.fetchManagedObject(managedObject: CDEmployee.self)
        guard records != nil && records?.count ?? 0 > 0 else {return nil}
        
        var recordsArray: [Employee] = []
        records!.forEach { employee in
            recordsArray.append(employee.convertToEmployee())
        }
       
    return recordsArray
    }
    
    func getItem(byIdentifier id: UUID) -> Employee?{
        let results = self.getCDEmployee(by: id)
        guard results != nil else {return nil}
       return results?.convertToEmployee()
    }
    
    func delete(byIdentifier id:UUID)->Bool {
        let results = self.getCDEmployee(by: id)
        guard results != nil else {return false}
        
        PersistentStore.shared.context.delete(results!)
        PersistentStore.shared.save()
        return true
    }
    
    func update(record: Employee) -> Bool {
        let results = self.getCDEmployee(by: record.id)
        guard results != nil else {return false}
       
        results?.profilePicture = results?.profilePicture
        results?.email = record._email
        results?.name = record._name
        
        results?.toPassport?.passportID = record.passport?._passportId
        results?.toPassport?.placeOfIssue = record.passport?._placeOfIssue
        
        try! PersistentStore.shared.context.save()
        return true
    }
    
    func getCDEmployee(by id:UUID )-> CDEmployee?{
        
        let fetch = NSFetchRequest<CDEmployee>(entityName:"CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetch.predicate = predicate
        
        do{
            let results = try PersistentStore.shared.context.fetch(fetch)
            guard results.count != 0 else {return nil}
            return results.first
            
            
            
        }catch let error{
        print(error)
        }
        return nil
    }
    
    typealias T = Employee
    
    
    
}

struct PassportDataRepository: PassportRepository{
    func delete(byIdentifier id: UUID) -> Bool {
        let results = self.getPasspostByID(byIdentifier: id)
        
        PersistentStore.shared.context.delete(results!)
       try! PersistentStore.shared.context.save()
        return true
    }
    
   
    
    func create(record: Passport) {
        let cdPassort = CDPassport(context:PersistentStore.shared.context)
        cdPassort.passportID = record._passportId
        cdPassort.placeOfIssue = record._placeOfIssue
        cdPassort.id = record._id
        
       try! PersistentStore.shared.context.save()
    }
    
    func getAllItems() -> [Passport]? {
        let results = PersistentStore.shared.fetchManagedObject(managedObject: CDPassport.self)
        guard results != nil && results?.count ?? 0 > 0 else {return nil}
        
        var passportArray = [Passport]()
        for passport in results!{
            passportArray.append(passport.convertToPassport())
        }
        return passportArray
    }
    
    func getItem(byIdentifier id: UUID) -> Passport? {
        let results = self.getPasspostByID(byIdentifier: id)
        guard results != nil else {return nil}
        return results?.convertToPassport()
    }
    
    func update(record: Passport) -> Bool {
        let results = self.getPasspostByID(byIdentifier: record._id)
        results?.passportID = record._passportId
        results?.placeOfIssue = record._placeOfIssue
        try! PersistentStore.shared.context.save()
        return true
    }
    
    func getPasspostByID(byIdentifier id:UUID) -> CDPassport?{
        
        let fetchRequest = NSFetchRequest<CDPassport>(entityName: "CDPassport")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        let results = try! PersistentStore.shared.context.fetch(fetchRequest)
        
        guard results.count > 0 else {return nil}
        return results.first
        
    }
    
    typealias T = Passport
    

    
    
}


