//
//  Passport.swift
//  onetooneCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation

class Passport{
    
    var _id: UUID
    var _passportId: String
    var _placeOfIssue: String
    var name: String?
    
    init(_id: UUID, _passportId: String, _placeOfIssue: String, name: String? = nil) {
        self._id = _id
        self._passportId = _passportId
        self._placeOfIssue = _placeOfIssue
        self.name = name
    }
}
