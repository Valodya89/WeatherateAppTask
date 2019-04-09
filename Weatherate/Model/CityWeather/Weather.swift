//
//  Weather.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class Weather: BaseModel {

    var weatherId = ""
    var main = ""
    var weatherDescription = ""
    var icon = ""

    override func mapping(map: Map) {
        super.mapping(map: map)
        weatherId <- map["id"]
        main <- map["main"]
        weatherDescription <- map["description"]
        icon <- map["icon"]
    }
}
