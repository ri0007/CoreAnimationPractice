//
//  CustomTextField.swift
//  CoreAnimationPractice
//
//  Created by 井上 龍一 on 2016/06/02.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    var underlineView: UIView!
    private let duration = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(self.didChangeValue), forControlEvents: .EditingChanged)
    }
    
    deinit {
        removeTarget(self, action: #selector(self.didChangeValue), forControlEvents: .EditingChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if underlineView == nil {
            underlineView = UIView()
            addSubview(underlineView)
        }
        
        borderStyle = .None
        layer.cornerRadius = 3
        underlineView.frame = CGRect(x: 0,
                                     y: frame.size.height-1,
                                     width: frame.size.width,
                                     height: 1)
        underlineView.backgroundColor = UIColor.lightGrayColor()
        layoutIfNeeded()
    }
    
    func addBecomeAnimation() {
        let lineAnimation = CABasicAnimation(keyPath: "backgroundColor")
        lineAnimation.delegate = self
        lineAnimation.fromValue = underlineView.layer.backgroundColor
        lineAnimation.toValue = UIColor.blackColor().CGColor
        lineAnimation.duration = duration
        lineAnimation.fillMode = kCAFillModeForwards
        lineAnimation.removedOnCompletion = false
        
        underlineView.layer.addAnimation(lineAnimation, forKey: "BecomeLineAnimation")
    }
    
    func addResignAnimation() {
        let lineAnimation = CABasicAnimation(keyPath: "backgroundColor")
        lineAnimation.delegate = self
        lineAnimation.fromValue = underlineView.layer.backgroundColor
        lineAnimation.toValue = UIColor.lightGrayColor().CGColor
        lineAnimation.duration = duration
        lineAnimation.fillMode = kCAFillModeForwards
        lineAnimation.removedOnCompletion = false
        
        underlineView.layer.addAnimation(lineAnimation, forKey: "ResignLineAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if underlineView.layer.animationForKey("BecomeLineAnimation") != nil {
            underlineView.layer.backgroundColor = UIColor.blackColor().CGColor
            underlineView.layer.removeAnimationForKey("BecomeLineAnimation")
        } else if underlineView.layer.animationForKey("ResignLineAnimation") != nil {
            underlineView.layer.backgroundColor = UIColor.lightGrayColor().CGColor
            underlineView.layer.removeAnimationForKey("ResignLineAnimation")
        }
    }
    
    func didChangeValue(sender: CustomTextField) -> Bool {
        sender.underlineView.layer.removeAllAnimations()
        sender.underlineView.layer.backgroundColor = UIColor.redColor().CGColor
        
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        if text?.characters.count == 0 {
            addBecomeAnimation()
        }
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        if text?.characters.count == 0 {
            addResignAnimation()
        }
        
        return super.resignFirstResponder()
    }
}
