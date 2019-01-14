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
    var isFetchingFromDB = false
    
    let fetchCharacterAction: Action<(CharacterListMap, Int), CharacterListMap, ServiceResponseError> =
        Action(execute: { (characterListMap, offset) -> SignalProducer<CharacterListMap, ServiceResponseError> in
            return NetworkServiceManager.sharedInstance.fetchCharacters(characterListMap: characterListMap, limit: Constants.characterPageLimit, offset: offset)
        })
    
    override init() {
        super.init()
        characterListMap <~ fetchCharacterAction.values
    }
    
    func fetchMoreCharacters() {
        isFetchingFromDB = true
        CharactersDataManager.sharedInstance.fetchCharacters(offset: characterListMap.value.offset, limit: Constants.characterPageLimit) { [weak self] charactersMapFromRealm in
            guard let `self` = self else { return }

            if charactersMapFromRealm.characters.isEmpty {
                self.fetchCharacterAction.apply((self.characterListMap.value, self.characterListMap.value.offset)).start()
            } else {
                self.characterListMap.value = charactersMapFromRealm
            }
            self.isFetchingFromDB = false
        }
    }
}
