//
//  Location.swift
//  WaterReport
//
//  Created by Hui Li on 3/8/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import Foundation

class Location {
    var latitude : Double!
    var longitude : Double!
    
    
    init(latitude: Double, longitude : Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func toArray() -> [AnyHashable:Any]{
        return ["Latitude" : latitude, "Longitude" : longitude] as [AnyHashable:Any]
    }
    
    
    
    
    
}
