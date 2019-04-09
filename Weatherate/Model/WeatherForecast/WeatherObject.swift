//
//  WeatherObject.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherObject: BaseModel {

    var dt = 0
    var dt_txt = ""
    var main: WeatherMain?
    var weather = [Weather]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        dt <- map["dt"]
        dt_txt <- map["dt_txt"]
        main <- map["main"]
        weather <- map["weather"]
    }
}
