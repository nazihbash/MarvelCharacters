//
//  Character.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/8/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class MarvelCharacter: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var imagePath: String = ""
    @objc dynamic var imageExtension: String = ""
    @objc dynamic var wikiUrl: String = ""
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        details <- map["description"]
        imagePath <- map["thumbnail.path"]
        imageExtension <- map["thumbnail.extension"]
        var charUrls: [CharacterUrl]?
        charUrls <- map["urls"]
        if let charUrls = charUrls, let charUrl = charUrls.filter({ $0.type == .detail }).first {
            self.wikiUrl = charUrl.url
        }
    }
    
    var imageUrl: String {
        return "\(imagePath).\(imageExtension)"
    }
}
class CharacterUrl: Mappable {
    
    var type: UrlType = .unknown
    var url: String = ""
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        type <- map["type"]
        url <- map["url"]
    }
}
enum UrlType: String {
    case unknown = ""
    case detail = "detail"
    case comiclink = "comiclink"
    
    init(safeRawValue: String) {
        self = UrlType(rawValue: safeRawValue) ?? .unknown
    }
}
