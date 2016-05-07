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
    @IBOutlet var display: UILabel!
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: self.view)
        let gravity = UIGravityBehavior(items: [self.button])
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [self.button])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressed(sender: UIButton) {
        if let text = sender.titleLabel?.text {
            display.text = text
        }
    }

}

@IBDesignable
class PHButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLook()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLook()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setupLook() {
        self.layer.cornerRadius = self.bounds.size.width/2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.systemFontOfSize(42)
        self.titleLabel?.textAlignment = .Center
    }
}

// Use an extension because we want every subclass of UIButton to exhibit the same behaviour. But is subclassing UIButton legal?
extension UIButton {
    override public var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                self.layer.borderColor = UIColor.clearColor().CGColor
                self.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
            }
            else {
                UIView.animateWithDuration(0.25, delay: 0.0, options: .AllowUserInteraction, animations: {
                    self.layer.backgroundColor = UIColor.clearColor().CGColor
                    self.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
                    }, completion: nil)
            }
            super.highlighted = newValue
        }
    }
}