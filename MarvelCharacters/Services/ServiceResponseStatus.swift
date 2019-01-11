import Foundation

enum ServiceResponseStatus: Int {
    
    case serverCodeNotOk
    case unknownServerError

//    // Authentication Spark codes
//    case expiredResponse = "2548a7f3-7bf4-4533-a6c1-dcbcfcdc26a5"
//    case deviceNeedsRegistered = "9c6120c8-c408-4357-a32f-8a38d42d879d"
//    case wrongUsernameandPass = "784db11a-9b74-4ce2-a0e6-1c23a268470e"
//    case refreshTokenFailed = "a277ee9e-755f-4e83-8ff9-19dd6ddc2184"
//    case invalidToken = "b419e0e0-af8a-413d-8af2-b3e1f7005193"
//    case loginError = "684db11a-9b74-4ce2-a0e6-1c23a268470f"
//    case validationFailed = "3bcda9a8-2c83-49af-89f0-c37321624fee"
//
//    // Activate Coupon
//    case offerAlreadyActivated = "1001"
//    case offerNotModifiable = "1002"
//    case offerShutoff = "5018"
    
    init(safeRawValue: Int) {
        self = ServiceResponseStatus(rawValue: safeRawValue) ?? .unknownServerError
    }
    
    var message: String {
        switch self {
//        case .flippUnprocessableEntity:
//            return Constants.Error.Message.Service.flippUnprocessableEntity
//        case .offerAlreadyActivated:
//            return Constants.Error.Message.Service.ActivateCoupon.offerAlreadyActivated
//        case .offerNotModifiable:
//            return Constants.Error.Message.Service.ActivateCoupon.offerNotModifiable
//        case .offerShutoff:
//            return Constants.Error.Message.Service.ActivateCoupon.offerShutoff
        default: return "error.default".localized
        }
    }
}
