//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import ReactiveSwift

class CharacterListViewModel: NSObject {
    
    let characterListMap: MutableProperty<CharacterListMap> = MutableProperty(CharacterListMap())
    
    let fetchCharacterAction: Action<(CharacterListMap, Int), CharacterListMap, ServiceResponseError> =
        Action(execute: { (characterListMap, offset) -> SignalProducer<CharacterListMap, ServiceResponseError> in
            return NetworkServiceManager.sharedInstance.fetchCharacters(characterListMap: characterListMap, limit: Constants.characterPageLimit, offset: offset)
        })
    
    override init() {
        super.init()
        characterListMap <~ fetchCharacterAction.values
    }
    
    func fetchMoreCharacters() {
        fetchCharacterAction.apply((characterListMap.value, characterListMap.value.offset)).start()
    }
}
