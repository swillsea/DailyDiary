//
//  AnimationViewController.swift
//  instaclone
//
//  Created by Pei Xiong on 4/12/16.
//  Copyright © 2016 Michael Merrill. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animateWithDuration(1, delay: 0, options: [.Repeat,.Autoreverse], animations: {
            //self.heartImageView.frame = CGRectMake(50, 50, 150, 150)
            self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: nil)
        
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:#selector(self.presentMainViewController), userInfo: nil, repeats: false)
    }
    
    
    func presentMainViewController(){
        self.performSegueWithIdentifier("navigation", sender: self)
    }

}
