//
//  ServiceManager.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceManager: URLRequestConvertible {

    case fetchCharacters(limit: Int, offset: Int)
    
    var path: String {
        switch self {
        case .fetchCharacters:
            return "characters"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    func asURLRequest() -> URLRequest {
        return createBaseRequest(baseUrl: Constants.baseUrl, path: path, method: method)
    }
    
    func createBaseRequest(baseUrl: String, path: String, method: Alamofire.HTTPMethod) -> URLRequest {
        
        let urlComp = NSURLComponents(string: "\(baseUrl)\(path)")!
        var items = [URLQueryItem]()
        
        switch self {
        case let .fetchCharacters(limit, offset):
            items.append(URLQueryItem(name: "limit", value: "\(limit)"))
            items.append(URLQueryItem(name: "offset", value: "\(offset)"))
        }
        
        items.append(URLQueryItem(name: "apikey", value: Constants.publicApiKey))
        let timeStamp = Int(Date().timeIntervalSince1970)
        items.append(URLQueryItem(name: "ts", value: "\(timeStamp)"))
        let hash = "\(timeStamp)\(Constants.privateApiKey)\(Constants.publicApiKey)".md5()
        items.append(URLQueryItem(name: "hash", value: hash))

        urlComp.queryItems = items
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.timeoutInterval = 30
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
