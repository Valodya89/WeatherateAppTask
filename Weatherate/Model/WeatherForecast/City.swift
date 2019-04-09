//
//  City.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class City: BaseModel {

    var coord = [String:Any]()
    var country = ""
    var name = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        coord <- map["coord"]
        country <- map["country"]
        name <- map["name"]
    }
}
