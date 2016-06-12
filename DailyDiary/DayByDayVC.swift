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
    @IBOutlet private var timeTextField: UITextField!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textView: UITextView!
    var moc: NSManagedObjectContext!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var timeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var wordCountLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var timeTextLabel: UILabel!
    @IBOutlet private weak var wordNumberLabel: UILabel!

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
    
    private func styleNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func showDiaryWithEntry(entry:Entry) {
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
    private func goBackOneEntry(){
        
        if self.index == self.resultsArray.count-1 {
            displayStatsView()
        } else if self.index == self.resultsArray.count-2 {
            resetToMainView()
            displayPreviousEntry()
        } else {
            displayPreviousEntry()
        }
    }
    
    private func goForwardOneEntry(){
        if self.index == 0 {
            displayAddNewView()
        } else if self.index == 1 {
            resetToMainView()
            displayNextEntry()
        } else {
            displayNextEntry()
        }
    }
    
    private func resetToMainView(){
        //enable forward and back buttons
        //change add button to "Edit"
        //remove view's border
        //change viewBackground to white
        //change time and wordCount Color back to customRed
        //change textView color to customGray
        //change textView fontSize back to 14?
    }
    
    private func displayStatsView(){
        
    }
    
    private func displayAddNewView(){
        performSegueWithIdentifier("toAddNewVC", sender: self)
        //disable back< button
        //Change date text to "Past Entries"
        //Change Edit button to "Add"
        //Add white border to view
        //change view background to clearColor
        //change Time and wordcount labels to clearColor
        //change textView color to white
        //change textView fontSize to 20?
        //change textView text to "Your last entry was \(lastWordCount) words. Try adding another."
    }
    
    private func displayPreviousEntry(){
        self.selectedEntry = resultsArray[self.index+1] as! Entry
        self.showDiaryWithEntry(self.selectedEntry)
        self.index = self.index + 1
    }
    
    private func displayNextEntry(){
        self.selectedEntry = resultsArray[self.index-1] as! Entry
        self.showDiaryWithEntry(self.selectedEntry)
        self.index = self.index - 1
    }
    
    @IBAction private func onLeftButtonPressed(sender: UIButton) {
        goForwardOneEntry()
    }
    
    @IBAction private func onRightButtonPressed(sender: UIButton) {
        goBackOneEntry()
    }
    
    //Allows us to override UITextView gesture recognition so entries are swipeable when swipes occur over text
    private func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction private func onSwipeRight(sender: UISwipeGestureRecognizer) {
        textView.scrollEnabled = false
        goBackOneEntry()
        textView.scrollEnabled = true

    }
    
    @IBAction private func onSwipeLeft(sender: UISwipeGestureRecognizer) {
        textView.scrollEnabled = false
        goForwardOneEntry()
        textView.scrollEnabled = true
    }
    
//MARK: Navigation
    @IBAction private func onDismissButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toAddNewVC" {
            let destVC = segue.destinationViewController as! AddNewDayByDayVC
            destVC.moc = self.moc

        } else {
            let destVC = segue.destinationViewController as! AddOrEditVC
            destVC.moc = self.moc
            destVC.entryBeingEdited = self.selectedEntry
        }
        
    }

}
