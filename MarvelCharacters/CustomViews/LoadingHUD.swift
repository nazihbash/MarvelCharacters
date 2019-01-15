import UIKit
import Lottie

class LoadingHUD: UIView {
    
    private var backingView: UIVisualEffectView!
    private var animationImageView: LOTAnimationView!
    private let ANIMATION_SPEED = 0.15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func configureUI() {
        
        backgroundColor = .clear
        backingView = UIVisualEffectView(effect: nil)
        
        backingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backingView)
        backingView.dockInSuperView()
        
        animationImageView = LOTAnimationView(name: "loading-animation")
        animationImageView.contentMode = .scaleAspectFit
        animationImageView.loopAnimation = true
        
        animationImageView.translatesAutoresizingMaskIntoConstraints = false
        backingView.contentView.addSubview(animationImageView)
        
        animationImageView.centerXAnchor.constraint(equalTo: backingView.contentView.centerXAnchor).isActive = true
        animationImageView.centerYAnchor.constraint(equalTo: backingView.contentView.centerYAnchor).isActive = true
        animationImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        animationImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        animationImageView.play()
        animationImageView.loopAnimation = true

        UIView.animate(withDuration: ANIMATION_SPEED) {
            self.backingView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: ANIMATION_SPEED, animations: {
            self.backingView.effect = nil
        }) { _ in
            self.animationImageView.stop()
            self.removeFromSuperview()
        }
    }
}
