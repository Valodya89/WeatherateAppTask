//
//  BaseModel.swift
//  Monamie
//
//  Created by Valodya Galstyan on 10/16/18.
//  Copyright © 2018 Valodya Galstyan. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: Mappable {
    
    var id = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
    }
}
