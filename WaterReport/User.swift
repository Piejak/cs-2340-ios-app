//
//  User.swift
//  WaterReport
//
//  Created by Hui Li on 2/26/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

struct User {
    
    var realname: String!
    var age: Int?
    var address: String?
    var affiliation: String?
    var accountType: AccountType!
    var uid: String!
    var key: String?
    var ref: FIRDatabaseReference?
    
    
    init(snapshot: FIRDataSnapshot) {
        
        key = snapshot.key
        ref = snapshot.ref
        realname = (snapshot.value! as! NSDictionary)["realname"] as! String
        age = (snapshot.value! as! NSDictionary)["age"] as? Int
        address = (snapshot.value! as! NSDictionary)["address"] as? String
        accountType = (snapshot.value! as! NSDictionary)["accountType"] as! AccountType
        uid = (snapshot.value! as! NSDictionary)["uid"] as! String
    }
    
}
