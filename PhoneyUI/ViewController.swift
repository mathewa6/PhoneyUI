//
//  ViewController.swift
//  PhoneyUI
//
//  Created by Adi Mathew on 5/5/16.
//  Copyright © 2016 RCPD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.layer.cornerRadius = button.bounds.size.width/2
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
        button.clipsToBounds = true
//        button.backgroundColor = UIColor.whiteColor()
        
//        let blurEffect = UIBlurEffect(style: .Light)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = button.bounds
//        button.addSubview(blurView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIButton {
    override public var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                UIView.animateWithDuration(0.3, animations: {
                    self.layer.borderColor = UIColor.clearColor().CGColor
                    self.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
                })
            }
            else {
                UIView.animateWithDuration(0.3, animations: {
                    self.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
                    self.layer.backgroundColor = UIColor.clearColor().CGColor
                })
            }
            super.highlighted = newValue
        }
    }
}