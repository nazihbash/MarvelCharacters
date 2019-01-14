//
//  UserDefaults+Extensions.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let charactersLastUpdated = "defaults_characters_last_updated"
    static let totalCharacters = "defaults_total_characters"
}

extension UserDefaults {
    
    var charactersLastUpdatedTime: String {
        get {
            return string(forKey: UserDefaultsKeys.charactersLastUpdated) ?? "2000-01-01T00:00:00"
        }
        set(newvalue) {
            set(newvalue, forKey: UserDefaultsKeys.charactersLastUpdated)
        }
    }
    var totalCharacters: Int {
        get {
            return integer(forKey: UserDefaultsKeys.totalCharacters)
        }
        set(newvalue) {
            set(newvalue, forKey: UserDefaultsKeys.totalCharacters)
        }
    }
}
