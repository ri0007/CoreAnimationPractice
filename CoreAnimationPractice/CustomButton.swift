//
//  CustomButton.swift
//  CoreAnimationPractice
//
//  Created by 井上 龍一 on 2016/06/03.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    private let duration = 0.3
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addObserver(self, forKeyPath: "enabled", options: [.Old, .New], context: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addObserver(self, forKeyPath: "enabled", options: [.Old, .New], context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "enabled")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 3
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "enabled" {
            guard let enabled = change!["new"] as? Bool else {
                return
            }
            
            if enabled == change!["old"] as? Bool {
                return
            }
            
            layer.removeAllAnimations()
            
            if enabled {
                addEnableAnimation()
            } else {
                addDisableAnimation()
            }
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if layer.animationForKey("EnableAnimation") != nil {
            layer.backgroundColor = UIColor.blueColor().CGColor
            layer.shadowOpacity = 0.5
            layer.removeAnimationForKey("EnableAnimation")
        } else if layer.animationForKey("DisableAnimation") != nil {
            layer.backgroundColor = UIColor.lightGrayColor().CGColor
            layer.shadowOpacity = 0.0
            layer.removeAnimationForKey("DisableAnimation")
        }
    }
    
    func addEnableAnimation() {
        let lineAnimation = CABasicAnimation(keyPath: "backgroundColor")
        lineAnimation.fromValue = layer.backgroundColor
        lineAnimation.toValue = UIColor.blueColor().CGColor
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fromValue = layer.shadowOpacity
        shadowAnimation.toValue = 0.5
        
        let animationGroup = CAAnimationGroup()
        animationGroup.delegate = self
        animationGroup.duration = duration
        animationGroup.animations = [lineAnimation,shadowAnimation]
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false
        layer.addAnimation(animationGroup, forKey: "EnableAnimation")
    }
    
    func addDisableAnimation() {
        let lineAnimation = CABasicAnimation(keyPath: "backgroundColor")
        lineAnimation.fromValue = layer.backgroundColor
        lineAnimation.toValue = UIColor.lightGrayColor().CGColor
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fromValue = layer.shadowOpacity
        shadowAnimation.toValue = 0.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [lineAnimation,shadowAnimation]
        animationGroup.delegate = self
        animationGroup.duration = duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false
        layer.addAnimation(animationGroup, forKey: "DisableAnimation")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
