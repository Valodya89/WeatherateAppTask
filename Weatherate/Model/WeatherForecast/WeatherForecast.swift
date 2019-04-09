//
//  WeatherForecast.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherForecast: BaseModel {

    var city: City?
    var list: [WeatherObject]?
    var cod = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        city <- map["city"]
        list <- map["list"]
        cod <- map["cod"]
    }
}
