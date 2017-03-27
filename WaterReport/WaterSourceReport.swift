//
//  WaterSourceReport.swift
//  WaterReport
//
//  Created by Hui Li on 3/26/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import Foundation


class WaterSourceReport {
    var location : Location
    var date : Date
    var reporter : User
    var waterType : WaterType
    var waterCondition : WaterCondition
    var number : Int;
    
    
    init(location : Location, date : Date, reporter : User, waterType : WaterType, waterCondition : WaterCondition, number : Int ) {
        self.location = location
        self.date = date
        self.reporter = reporter
        self.waterType = waterType
        self.waterCondition = waterCondition
        self.number = number
    }
    
    
    
    
    
    
    
}
