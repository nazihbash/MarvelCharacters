//
//  BaseViewController.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/9/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import UIKit
import ReactiveSwift

class BaseViewController: UIViewController {
    var disposables = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObserving()
    }
    
    private func setupKeyboardObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func dispose() {
        disposables.dispose()
    }
    
    deinit {
        dispose()
    }
}

extension BaseViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let scrollView = self.view.subviews.compactMap({ $0 as? UIScrollView }).first {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                var contentInset = scrollView.contentInset
                contentInset.bottom = keyboardHeight
                scrollView.contentInset = contentInset
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if let scrollView = self.view.subviews.compactMap({ $0 as? UIScrollView }).first {
            var contentInset = scrollView.contentInset
            contentInset.bottom = 0
            scrollView.contentInset = contentInset
        }
    }
}
