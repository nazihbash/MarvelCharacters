import Foundation
import UIKit
import MessageUI

extension UIViewController {
    func showAlert(title: String? = nil, message: String, onDismiss: (() -> Void)? = nil) {
        let alertController = UIAlertController.createAlert(title: title, message: message, onDismiss: onDismiss)
        self.present(alertController, animated: true)
    }
    func showGeneralProcessingError(onDismiss: (() -> Void)? = nil) {
        showAlert(title: "error.title".localized, message: "error.default".localized, onDismiss: onDismiss)
    }
    func showError(error: ServiceResponseError?, onDismiss: (() -> Void)? = nil) {
        if let error = error, case let .serverError(serviceError) = error {
            if !serviceError.message.isEmpty {
                showAlert(title: "error.title".localized, message: serviceError.message, onDismiss: onDismiss)
            } else {
                showGeneralProcessingError(onDismiss: onDismiss)
            }
        } else {
            if let error = error, case .notConnectedToInternet = error {
                NetworkReachabiltyHelper.sharedInstance.showNoNetworkDialog()
            } else {
                showGeneralProcessingError(onDismiss: onDismiss)
            }
        }
    }
    func isVisible() -> Bool {
        return isViewLoaded && view.window != nil && view.window!.isKeyWindow
    }
    func showProgressAnimation() {
        self.view.endEditing(false)
        ProgressAnimationHelper.sharedInstance.showProgressAnimation()
    }
    func hideProgressAnimation() {
        ProgressAnimationHelper.sharedInstance.hideProgressAnimation()
    }
}
