//
//  CDEmployee+CoreDataProperties.swift
//  onetooneCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var name: String?
    @NSManaged public var profilePicture: Data?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var toPassport: CDPassport?
    
    func convertToEmployee()->Employee{
        return Employee(_name: self.name!, _email: self.email!, profilePicture: self.profilePicture!, id: self.id!, passport: self.toPassport?.convertToPassport())
    }

}

extension CDEmployee : Identifiable {

}
