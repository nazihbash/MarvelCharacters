//
//  ApplicationHelper.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation

struct ApplicationHelper {
    
    static func isNullOrEmpty(_ string: String?) -> Bool {
        guard let string = string else { return true }
        return string.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }
}
