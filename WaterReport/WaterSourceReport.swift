//
//  WaterScourceReport.swift
//  WaterReport
//
//  Created by Hui Li on 4/9/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit

class WaterSourceReport: NSObject {
    var location : [AnyHashable : Any]!
    var date : String!
    var reporter : String!
    var waterType : String!
    var waterCondition : String!
    var reportNumber : Int!;
    
    
    //    init(location : Location, date : String, reporter : String, waterCondition : WaterCondition.RawValue, waterType : WaterType.RawValue, Reportnumber : Int ) {
    //        self.location = location
    //        self.date = date
    //        self.reporter = reporter
    //        self.waterType = waterType
    //        self.waterCondition = waterCondition
    //        self.Reportnumber = Reportnumber
    //    }
}
