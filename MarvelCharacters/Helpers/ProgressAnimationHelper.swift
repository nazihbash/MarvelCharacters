import Foundation
import UIKit
import Lottie

public class ProgressAnimationHelper: NSObject {

    static let sharedInstance: ProgressAnimationHelper = ProgressAnimationHelper()
    var currentAnimationView: LoadingHUD?
   
    func showProgressAnimation() {
        if currentAnimationView != nil {
            return
        }
        self.currentAnimationView = LoadingHUD(frame: .zero)
        
        guard let currentAnimationView = self.currentAnimationView else { return }

        UIApplication.shared.keyWindow?.addSubview(currentAnimationView)
        currentAnimationView.dockInSuperView()
    }
    
    func hideProgressAnimation() {
        if let currentAnimationView = currentAnimationView {
            currentAnimationView.dismiss()
            self.currentAnimationView = nil
        }
    }
}
