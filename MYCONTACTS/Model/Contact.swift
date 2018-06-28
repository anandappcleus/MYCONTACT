//
//  Contact.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 26/06/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import Foundation
import RealmSwift

class Contact:Object {
    
    @objc dynamic var firstName : String = ""
    @objc dynamic var lastName:String = ""
    @objc dynamic var phone : String = ""
    @objc dynamic var email : String = ""
    @objc dynamic var countryCode : String = ""
    
    convenience init(firstName:String,lastName:String,phone:String,email:String,countryCode:String)
    {
        self.init()
        
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.countryCode = countryCode
        
    }
    
    
    
}
