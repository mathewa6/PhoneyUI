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
    @IBOutlet var allButtons: [PHButton]!
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: self.view)
//        animator.setValue(true, forKey: "debugEnabled")
        
        let field = UIFieldBehavior.vortexField()
        field.strength = 0.5
        field.position = self.view.center
        for button in self.allButtons {
            field.addItem(button)
        }
        animator.addBehavior(field)
        let grav = UIFieldBehavior.radialGravityFieldWithPosition(self.view.center)
        grav.strength = 1
        for button in self.allButtons {
            grav.addItem(button)
        }
        animator.addBehavior(grav)
        
        let collision = UICollisionBehavior(items: self.allButtons)
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
    //ONLY needed for collisions in UIDynamics.
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .Ellipse
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width/2
    }
    
    func setupLook() {
        self.layer.borderWidth = 2.5
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