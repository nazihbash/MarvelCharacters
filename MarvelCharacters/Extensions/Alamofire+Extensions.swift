//
//  Alamofire+Extensions.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

extension DataRequest {
    
    func debugLog() -> DataRequest {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
    
    public static func objectMapperSerializer<T: BaseMappable>(_ keyPath: String?, mapToObject object: T? = nil, context: MapContext? = nil) -> DataResponseSerializer<T> {
        return DataResponseSerializer { request, response, data, error in
            logResponse(data: data, responseHeaders: response?.allHeaderFields)
            guard data != nil, response != nil else {
                return .failure(ServiceResponseError(error: error! as NSError))
            }
            if !(response!.statusCode >= 200 && response!.statusCode <= 299) {
                return .failure(ServiceResponseError.serverError(error: ServiceResponseStatus(safeRawValue: response!.statusCode)))
            }
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)
            let JSONToMap: Any?
            if let keyPath = keyPath, keyPath.isEmpty == false {
                JSONToMap = (result.value as AnyObject?)?.value(forKeyPath: keyPath)
            } else {
                JSONToMap = result.value
            }
            if let object = object {
                _ = Mapper<T>().map(JSONObject: JSONToMap, toObject: object)
                return .success(object)
            } else if let parsedObject = Mapper<T>(context: context).map(JSONObject: JSONToMap) {
                return .success(parsedObject)
            }
            return .failure(ServiceResponseError.serverError(error: ServiceResponseStatus.unknownServerError))
        }
    }
    @discardableResult public func responseObject<T: BaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.objectMapperSerializer(keyPath, mapToObject: object, context: context), completionHandler: completionHandler)
    }
    @discardableResult
    public func responseArray<T: BaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.objectMapperArraySerializer(keyPath, context: context), completionHandler: completionHandler)
    }
    public static func objectMapperArraySerializer<T: BaseMappable>(_ keyPath: String?, context: MapContext? = nil) -> DataResponseSerializer<[T]> {
        return DataResponseSerializer { request, response, data, error in
            logResponse(data: data, responseHeaders: response?.allHeaderFields)
            guard data != nil, response != nil else {
                return .failure(ServiceResponseError(error: error! as NSError))
            }
            if !(response!.statusCode >= 200 && response!.statusCode <= 299) {
                return .failure(ServiceResponseError.serverError(error: ServiceResponseStatus(safeRawValue: response!.statusCode)))
            }
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)
            let JSONToMap: Any?
            if let keyPath = keyPath, keyPath.isEmpty == false {
                JSONToMap = (result.value as AnyObject?)?.value(forKeyPath: keyPath)
            } else {
                JSONToMap = result.value
            }
            if let parsedObject = Mapper<T>(context: context).mapArray(JSONObject: JSONToMap) {
                return .success(parsedObject)
            }
            return .failure(ServiceResponseError.serverError(error: ServiceResponseStatus.unknownServerError))
        }
    }
    private static func logResponse(data: Data?, responseHeaders: [AnyHashable : Any]?) {
        #if DEBUG
        if let data = data {
            if let json = String(data: data, encoding: .utf8) {
                print("--------------------  -------------------")
                    if let headers = responseHeaders {
                        print("Response Headers:")
                        for (key, value) in headers {
                            print("\(key): \(value)")
                        }
                    }
                print("Response:")
                print(json)
                print("--------------------  -------------------")
            }
        }
        #endif
    }
}
