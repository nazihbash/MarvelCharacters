//
//  NetworkReachabilityHelper.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import Foundation
import Reachability

class NetworkReachabiltyHelper {
    var reachability: Reachability! = Reachability()
    var alert: UIAlertController?
    
    static let sharedInstance: NetworkReachabiltyHelper = NetworkReachabiltyHelper()
    
    private init() {
        reachability.whenUnreachable = { [weak self] _ in
            guard let `self` = self else { return }
            self.showNoNetworkDialog()
        }
        reachability.whenReachable = { [weak self] _ in
            guard let `self` = self else { return }
            self.hideNoNetworkDialog()
        }
    }
    
    func startReachability() {
        // detect Network connectivity
        try? reachability.startNotifier()
    }
    
    func stopReachability() {
        reachability.stopNotifier()
    }
    
    func showNoNetworkDialog() {
        if let alert = alert {
            alert.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
        alert = UIAlertController.createAlert(title: "dialog.nonetwork".localized, message: "dialog.turnonwifi".localized) { [weak self] in
            self?.alert = nil
        }
        alert?.showOnTop()
    }
    
    func hideNoNetworkDialog() {
        if alert != nil {
            alert?.dismiss(animated: true, completion: nil)
            alert = nil
        }
    }
}
