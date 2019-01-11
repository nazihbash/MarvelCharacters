//
//  BaseMap.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/8/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseMap<T>: Mappable where T: Mappable {
    
    var status: String = ""
    var data: T?
    var message: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        message <- map["message"]
    }
}
