//
//  UIAlertViewController+Extensions.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func createAlert(title: String?, message: String, onDismiss: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "common.ok".localized, style: .default) { (_: UIAlertAction) in
            onDismiss?()
        }
        alertController.addAction(OKAction)
        return alertController
    }
    
    func showOnTop() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
