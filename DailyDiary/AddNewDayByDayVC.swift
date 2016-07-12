//
//  AddNewDayByDayVC.swift
//  Quotidian
//
//  Created by Sam on 6/12/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import CoreData

class AddNewDayByDayVC: UIViewController {

    @IBOutlet weak var userPromptLabel: UILabel!
    @IBOutlet weak var addRoundButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    var moc: NSManagedObjectContext!
    var lastEntryWordCount : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 14
        cardView.clipsToBounds = true
        cardView.layer.borderColor = UIColor.whiteColor().CGColor
        cardView.layer.borderWidth = 1.0
        
        addRoundButton.layer.cornerRadius = addRoundButton.frame.width/2
        addRoundButton.clipsToBounds = true
        addRoundButton.layer.borderColor = UIColor.whiteColor().CGColor
        addRoundButton.layer.borderWidth = 1.0
        
        userPromptLabel.text = "Your last entry had \(lastEntryWordCount!.lowercaseString). Try adding a longer entry."
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation:UIStatusBarAnimation.None)
        self.prefersStatusBarHidden()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    @IBAction func onSwipeLeft(sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func onBackPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func onLastEntryPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(false)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! AddOrEditVC // since we're going to a navigation controller
        destVC.moc = self.moc
    }
}
