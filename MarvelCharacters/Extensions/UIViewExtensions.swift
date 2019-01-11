import UIKit

extension UIView {
    
    func loadViewFromViewNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        return view
    }
    
    func dockInSuperView() {
        dockInSuperView(leading: true, trailing: true, top: true, bottom: true)
    }
    
    func dockInSuperView(leading: Bool, trailing: Bool, top: Bool, bottom: Bool, constant: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        
        if leading {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        }
        if trailing {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
        }
        if top {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        }
        if bottom {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
        }
    }
    
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
