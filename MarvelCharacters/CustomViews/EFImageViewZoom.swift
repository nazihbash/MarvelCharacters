//
//  EFImageViewZoom.swift
//  EFImageViewZoom
//
//  Created by Ezequiel França on 27/05/17.
//  Copyright © 2017 Ezequiel França. All rights reserved.
//

import UIKit

public protocol EFImageViewZoomDelegate : class {
    func didZoom(zoomingScale: CGFloat)
    func didEndZooming()
}

public class EFImageViewZoom: UIScrollView {
    
    public weak var _delegate: EFImageViewZoomDelegate?
    var imageView: UIImageView!
    
    public var imageUrl: String! {
        didSet{
            guard let _imageView = self.imageView else { return }
            _imageView.kf.setImage(with: URL(string: imageUrl))
        }
    }
    
    public var imageViewCornerRadius: CGFloat = 0.0 {
        didSet{
            guard let _imageView = self.imageView else { return }
            _imageView.layer.cornerRadius = imageViewCornerRadius
        }
    }
    
    @IBInspectable public var _minimumZoomScale: CGFloat = 1.0 {
        didSet{
            self.minimumZoomScale = _minimumZoomScale
        }
    }
    
    @IBInspectable public var _maximumZoomScale: CGFloat = 6.0 {
        didSet{
            self.maximumZoomScale = _maximumZoomScale
        }
    }
    
    public var imageViewContentMode : UIView.ContentMode = .scaleAspectFit {
        didSet{
            guard let _imageView = self.imageView else { return }
            self.contentMode = imageViewContentMode
            _imageView.contentMode = imageViewContentMode
            self.sizeToFit()
            self.contentSize = _imageView.intrinsicContentSize
        }
    }
    
    public var highlightedImage: UIImage? = nil {
        didSet {
            self.imageView.highlightedImage = highlightedImage
        }
    }
    
    public var isHighlighted: Bool = false {
        didSet {
            self.imageView.isHighlighted = isHighlighted
        }
    }
    
    public var animationImages: [UIImage]? = nil {
        didSet {
            self.imageView.animationImages = animationImages
        }
    }
    
    public var highlightedAnimationImages: [UIImage]? = nil {
        didSet{
            self.imageView.highlightedAnimationImages = highlightedAnimationImages
        }
    }
    
    public var animationDuration: TimeInterval = TimeInterval() {
        didSet{
            self.imageView.animationDuration = animationDuration
        }
    }
    
    public var animationRepeatCount: Int = 0 {
        didSet{
            self.imageView.animationRepeatCount = animationRepeatCount
        }
    }
    
    override public var tintColor: UIColor! {
        didSet{
            self.imageView.tintColor = tintColor
        }
    }
    
    public func startAnimating() {
        self.imageView.startAnimating()
    }
    
    public func stopAnimating() {
        self.imageView.stopAnimating()
    }
    
    public var isAnimating: Bool {
        get{
            return self.imageView.isAnimating
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if imageView == nil {
            imageView = UIImageView(frame: rect)
            imageView.contentMode = imageViewContentMode
            contentMode = imageViewContentMode
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageViewCornerRadius
            addSubview(imageView)
            showsHorizontalScrollIndicator = false
            showsVerticalScrollIndicator = false
            delegate = self
        }
        imageView.kf.setImage(with: URL(string: imageUrl))
    }
}

extension EFImageViewZoom: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self._delegate?.didZoom(zoomingScale: self.zoomScale)
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.setZoomScale(1.0, animated: true)
        self._delegate?.didEndZooming()
    }
}
