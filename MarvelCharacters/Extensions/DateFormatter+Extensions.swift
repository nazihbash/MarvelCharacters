//
//  DataFormatter+Extensions.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var defaultDateFormatter: DateFormatter {
        return DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss", locale: Constants.Locale.enUSPosix)
    }
}
