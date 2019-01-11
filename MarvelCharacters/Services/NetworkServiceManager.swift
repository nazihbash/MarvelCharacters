//
//  NetworkServiceManager.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import ReactiveSwift
import MapKit

class NetworkServiceManager: NSObject {
    
    static let sharedInstance: NetworkServiceManager = NetworkServiceManager()
    
    let sessionManager: SessionManager!
    
    private override init() {
        let sessionConfiguration = URLSessionConfiguration.default
        var serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        if let url = URL(string: Constants.baseUrl), let host = url.host {
            serverTrustPolicies = [host: ServerTrustPolicy.disableEvaluation]
        }
        sessionManager = SessionManager(configuration: sessionConfiguration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        super.init()
    }
    func fetchCharacters(characterListMap: CharacterListMap, limit: Int, offset: Int) -> SignalProducer<CharacterListMap, ServiceResponseError> {
        return SignalProducer { [weak self] (observer, _) in
            let request = ServiceManager.fetchCharacters(limit: limit, offset: offset)
            self?.sessionManager.request(request).debugLog().responseObject(completionHandler: { (response: DataResponse<BaseMap<CharacterListMap>>) in
                if let value = response.value, let data = value.data {
                    data.characters = characterListMap.characters + data.characters
                    observer.send(value: data)
                    observer.sendCompleted()
                } else
                    if let error = (response.error as? ServiceResponseError) {
                        observer.send(error: error)
                }
            })
        }
    }
}
