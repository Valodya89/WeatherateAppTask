//
//  CityWeather.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class CityWeather: BaseModel {

    var coord = [String:Any]()
    var weather = [Weather]()
    var base = ""
    var main: WeatherMain?
    var visibility = ""
    var wind = [String:Any]()
    var clouds = [String:Any]()
    var dt = ""
    var sys = [String:Any]()
    var CityWeatherId = ""
    var name = ""
    var cod = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        CityWeatherId <- map["id"]
        coord <- map["coord"]
        weather <- map["weather"]
        base <- map["base"]
        main <- map["main"]
        visibility <- map["visibility"]
        wind <- map["wind"]
        clouds <- map["clouds"]
        dt <- map["dt"]
        sys <- map["sys"]
        name <- map["name"]
        cod <- map["cod"]
    }
}
