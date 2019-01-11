//
//  CharacterListMap.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/8/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import ObjectMapper

class CharacterListMap: Mappable {
    
    var offset: Int = 0
    var limit: Int = 0
    var total: Int = 0  //The total number of resources available given the current filter set.
    var characters: [MarvelCharacter] = []
    
    required init?(map: Map) {
        
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        characters <- map["results"]
    }
}
