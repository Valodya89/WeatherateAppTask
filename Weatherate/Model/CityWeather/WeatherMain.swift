//
//  WeatherMain.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherMain: BaseModel {
    
    var humidity = 0
    var pressure = 0
    var temp = 0
    var temp_max = 0
    var temp_min = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        humidity <- map["humidity"]
        pressure <- map["pressure"]
        temp <- map["temp"]
        temp_max <- map["temp_max"]
        temp_min <- map["temp_min"]
    }
}
