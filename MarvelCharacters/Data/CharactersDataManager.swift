//
//  CharactersDataManager.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import ObjectMapper

class CharactersDataManager {

    public static let sharedInstance : CharactersDataManager = CharactersDataManager()

    private init() {
        let dateFormatter = DateFormatter.defaultDateFormatter
        if let date = dateFormatter.date(from:UserDefaults.standard.charactersLastUpdatedTime) {
            let diff = date.differenceInDaysFromNow()
            if diff > 2 {
                DispatchQueue.main.async {
                    RealmHelper.sharedInstance.deleteAll()
                }
            }
        }
    }
    
    func fetchCharacters(offset: Int, limit: Int, onCompletion: @escaping (CharacterListMap)->()) {
        DispatchQueue.main.async {
            var time = Date().timeIntervalSince1970
            let realmObjs  = RealmHelper.sharedInstance.getObjects(type: MarvelCharacter.self)
            if realmObjs.count > 0 {
                time = Date().timeIntervalSince1970 - time
                print("\n\n \(realmObjs.count) characters fetched from realm in \(time) seconds \n\n")
            }
            
            let characters = Array(realmObjs) as! [MarvelCharacter]
            var pagedCharacters: [MarvelCharacter] = []
            var length = max(0, characters.count - offset)
            length = min(limit, length)
            if length > 0 {
                pagedCharacters = Array(characters.prefix(offset + length))
            }
            
            let characterListMap = CharacterListMap()
            characterListMap.offset = offset
            characterListMap.total = UserDefaults.standard.totalCharacters
            characterListMap.limit = limit
            characterListMap.characters = pagedCharacters
            onCompletion(characterListMap)
        }
    }

    func updateCharacters(characters: [MarvelCharacter]) {
        DispatchQueue.main.async {
            RealmHelper.sharedInstance.add(items: characters)
            UserDefaults.standard.charactersLastUpdatedTime = DateFormatter.defaultDateFormatter.string(from: Date())
        }
    }
}
