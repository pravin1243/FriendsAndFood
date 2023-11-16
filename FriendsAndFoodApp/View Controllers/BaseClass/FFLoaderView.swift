//
//  SLLoaderView.swift
//  Loader
//
//  Created by Oldrin Mendez on 06/10/16.
//  Copyright © 2016 QBurst. All rights reserved.
//

import UIKit

class FFLoaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let replicateLayer = CAReplicatorLayer()
    var loaderSize:CGFloat = 100.0
    let duration:CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateUI()
    }
    
    func updateUI() {

        self.backgroundColor = UIColor.clear

        replicateLayer.bounds = CGRect(x: 0, y: 0, width: loaderSize, height: loaderSize)
        replicateLayer.position = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        replicateLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(replicateLayer)
        
        replicateLayer.sublayers?.removeAll()
        
        let roundLayer = CALayer()
        roundLayer.frame = CGRect(x: 0, y: 0, width: 5.0, height: 5.0)
        roundLayer.position = CGPoint(x: replicateLayer.bounds.size.width / 2.0, y: 0)
        roundLayer.cornerRadius = roundLayer.frame.size.width / 2.0
        roundLayer.backgroundColor = UIColor.gray.cgColor
        roundLayer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        replicateLayer.addSublayer(roundLayer)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.1
        scaleAnimation.duration = CFTimeInterval(duration)
        scaleAnimation.autoreverses = false
        scaleAnimation.repeatCount = Float.infinity
        roundLayer.add(scaleAnimation, forKey: nil)
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor");
        colorAnimation.fromValue = UIColor.gray.cgColor
        colorAnimation.toValue = UIColor.gray.withAlphaComponent(0.1)
        colorAnimation.duration = CFTimeInterval(duration);
        colorAnimation.repeatCount = Float.infinity;
        roundLayer.add(scaleAnimation, forKey: nil)

        let count:CGFloat = loaderSize / 2.0
        
        replicateLayer.instanceCount = Int(count)
        replicateLayer.instanceDelay = CFTimeInterval(duration / CGFloat(count))
        let angle = CGFloat(2*M_PI) / CGFloat(count)
        replicateLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
    }
    
    
    override func layoutSubviews() {
        updateUI()
    }
    
    func hide() {
        
        self.removeFromSuperview()
    }
    
    
    class func existInView(view:UIView?) -> FFLoaderView? {
        
        guard let superView = view else {
            return nil
        }
        
        for subView in superView.subviews {
            
            if subView is FFLoaderView {
                
                return subView as? FFLoaderView
            }
        }
        
        return nil
    }
    
    @discardableResult class func showInView(view:UIView?, loaderSize:CGFloat = 30.0) -> FFLoaderView? {
        
        if view == nil {
            return nil
        }
        
        var loaderView:FFLoaderView! = self.existInView(view: view)
        
        if loaderView == nil {
            loaderView = FFLoaderView(frame: view!.bounds)
        } else {
            return loaderView
        }
        
        loaderView.loaderSize = loaderSize
        
        loaderView.tag = 5468
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        view?.addSubview(loaderView)
        
        let views = ["Loader" : loaderView, "superView": view]

        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[Loader]-0-|", options: NSLayoutConstraint.FormatOptions.directionLeftToRight, metrics: nil, views: views as [String : Any])
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[Loader]-0-|", options: NSLayoutConstraint.FormatOptions.directionLeftToRight, metrics: nil, views: views as [String : Any])
        
        view?.addConstraints(horizontalConstraints)
        
        view?.addConstraints(verticalConstraints)
        
        return loaderView
    }
    
    class func hideInView(view:UIView?) {
        
        FFLoaderView.existInView(view: view)?.removeFromSuperview()

    }

}
