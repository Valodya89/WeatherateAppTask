//
//  WFNextDays.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class WFNextDays: BaseModel {

    var dt = 0
    var temp: WeatherDay?
    var weather = [Weather]()
    override func mapping(map: Map) {
        super.mapping(map: map)
        dt <- map["dt"]
        temp <- map["temp"]
        weather <- map["weather"]
    }
}
