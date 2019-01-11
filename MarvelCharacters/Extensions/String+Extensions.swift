//
//  String+Extensions.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import CommonCrypto
import Foundation

extension String {
    func md5() -> String {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return  digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
