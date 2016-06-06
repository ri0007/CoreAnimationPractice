//
//  ViewController.swift
//  CoreAnimationPractice
//
//  Created by 井上 龍一 on 2016/05/29.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var passField: CustomTextField!
    @IBOutlet weak var joinButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabelAnimation()
        
        nameField.delegate = self
        passField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if nameField.text?.characters.count > 0 && passField.text?.characters.count >= 4 {
            joinButton.enabled = true
        } else {
            joinButton.enabled = false
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == passField {
            joinButton.enabled = nameField.text!.characters.count > 0
                                    && textField.text!.characters.count + string.characters.count - range.length >= 4
        } else {
            joinButton.enabled = textField.text!.characters.count + string.characters.count > 0
                                    && passField.text!.characters.count >= 4
        }
        
        return true
    }
    
    @IBAction func didClickedView(sender: AnyObject) {
        if nameField.isFirstResponder() {
            nameField.resignFirstResponder()
        }
        else if passField.isFirstResponder() {
            passField.resignFirstResponder()
        }
    }
    
    func addLabelAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = label.layer.opacity
        animation.toValue = 0.2
        animation.duration = 1.0
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        
        label.layer.addAnimation(animation, forKey: "LabelAnimation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

