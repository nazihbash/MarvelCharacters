import Foundation

enum ServiceResponseError: Error {
    case unknown
    case notConnectedToInternet
    case serverError(error: ServiceResponseStatus)
    
    init(error: NSError? = nil) {
        if let error = error {
            if error.domain == NSURLErrorDomain {
                switch error.code {
                case NSURLErrorTimedOut,
                     NSURLErrorNetworkConnectionLost,
                     NSURLErrorCannotFindHost,
                     NSURLErrorCannotConnectToHost,
                     NSURLErrorDNSLookupFailed,
                     NSURLErrorDNSLookupFailed,
                     NSURLErrorNotConnectedToInternet,
                     NSURLErrorInternationalRoamingOff:
                    self = .notConnectedToInternet
                default:
                    self = .unknown
                }
            } else {
                self = .unknown
            }
        } else {
            self = .unknown
        }
    }
    
}
