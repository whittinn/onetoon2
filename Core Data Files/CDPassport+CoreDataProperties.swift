//
//  CDPassport+CoreDataProperties.swift
//  onetooneCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//
//

import Foundation
import CoreData


extension CDPassport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPassport> {
        return NSFetchRequest<CDPassport>(entityName: "CDPassport")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var passportID: String?
    @NSManaged public var placeOfIssue: String?
    @NSManaged public var toEmployee: CDEmployee?
    
    func convertToPassport()->Passport{
        return Passport(_id: self.id!, _passportId: self.passportID!, _placeOfIssue: self.placeOfIssue!, name: self.toEmployee?.name)
    }

}

extension CDPassport : Identifiable {

}
