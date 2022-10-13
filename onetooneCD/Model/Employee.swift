//
//  Employee.swift
//  onetooneCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation

class Employee{
    
    var _name:String
    var _email:String
    var profilePicture: Data
    var id: UUID
    var passport: Passport?
    
    init(_name: String, _email: String, profilePicture: Data, id: UUID, passport: Passport? = nil) {
        self._name = _name
        self._email = _email
        self.profilePicture = profilePicture
        self.id = id
        self.passport = passport
    }
    
    
}
