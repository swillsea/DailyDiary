//
//  StatsVC.swift
//  Quotidian
//
//  Created by Sam on 7/12/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {

    @IBOutlet weak var cardView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 14
        cardView.clipsToBounds = true
        cardView.layer.borderColor = UIColor.whiteColor().CGColor
        cardView.layer.borderWidth = 1.0
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation:UIStatusBarAnimation.None)
        self.prefersStatusBarHidden()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func onBackPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func onLastEntryPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(false)
    }

}
