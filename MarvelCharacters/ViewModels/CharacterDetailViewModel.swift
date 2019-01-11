//
//  CharacterDetailViewModel.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import ReactiveSwift

class CharacterDetailViewModel: NSObject {
    
    var character: MarvelCharacter!
    
    init(character: MarvelCharacter) {
        super.init()
        self.character = character
    }
}
