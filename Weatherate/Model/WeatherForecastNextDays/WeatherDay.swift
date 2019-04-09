//
//  WeatherDay.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherDay: BaseModel {

    var day = 0

    override func mapping(map: Map) {
        super.mapping(map: map)
        
        day <- map["day"]
    }
}
