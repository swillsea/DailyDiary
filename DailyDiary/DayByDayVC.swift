//
//  DayByDayVC.swift
//  Quotidian
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import UIKit
import CoreData

class DayByDayVC: UIViewController, UIScrollViewDelegate {
    var resultsArray : [NSManagedObject]!
    var selectedEntry: Entry!
    var index:NSInteger!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    var moc: NSManagedObjectContext!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var timeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordCountLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var wordNumberLabel: UILabel!

//MARK: Appearance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleNavBar()
        self.prefersStatusBarHidden()
        self.cardView.layer.cornerRadius = 14
        self.cardView.clipsToBounds = true
        if self.resultsArray.count != 0 {
            self.selectedEntry = resultsArray[self.index] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation:UIStatusBarAnimation.None)
        self.showDiaryWithEntry(self.selectedEntry)
    }
    
    func styleNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showDiaryWithEntry(entry:Entry) {
        let dateFormat = NSDateFormatter()
        dateFormat.dateStyle = .MediumStyle
        self.timeTextField.text = dateFormat.stringFromDate(entry.date!)
        
        if selectedEntry.imageData != nil {
            self.imageView.image = UIImage(data:entry.imageData!)
            self.timeLabelTopConstraint.constant = 13
            self.wordCountLabelTopConstraint.constant = 13
        } else {
            self.imageView.image = nil
            self.timeLabelTopConstraint.constant = 13-self.imageView.frame.height
            self.wordCountLabelTopConstraint.constant = 13-self.imageView.frame.height
        }
        
        self.textView.text = entry.text
        self.textView.setContentOffset(CGPointMake(0.0, 0.0), animated: false)
        self.wordNumberLabel.text = selectedEntry.text!.asWordCountString()
        self.timeTextLabel.text = self.selectedEntry.date?.time()
        
    }

//MARK: Moving through Entries
    func goBackOneEntry(){
        if self.index == self.resultsArray.count-1 {
        } else {
            self.selectedEntry = resultsArray[self.index+1] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
            self.index = self.index + 1
        }
    }
    
    func goForwardOneEntry(){
        if self.index == 0 {
        } else {
            self.selectedEntry = resultsArray[self.index-1] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
            self.index = self.index - 1
        }
    }
    
    @IBAction func onLeftButtonPressed(sender: UIButton) {
        goForwardOneEntry()
    }
    
    @IBAction func onRightButtonPressed(sender: UIButton) {
        goBackOneEntry()
    }
    
    //Allows us to override UITextView gesture recognition so entries are swipeable when swipes occur over text
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func onSwipeRight(sender: UISwipeGestureRecognizer) {
        textView.scrollEnabled = false
        goBackOneEntry()
        textView.scrollEnabled = true

    }
    
    @IBAction func onSwipeLeft(sender: UISwipeGestureRecognizer) {
        textView.scrollEnabled = false
        goForwardOneEntry()
        textView.scrollEnabled = true
    }
    
//MARK: Navigation
    @IBAction func onDismissButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! AddOrEditVC // since we're going to a navigation controller
        
        destVC.moc = self.moc
        destVC.entryBeingEdited = self.selectedEntry
        
    }

}
