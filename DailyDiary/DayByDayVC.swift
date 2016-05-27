//
//  DayByDayVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import CoreData

class DayByDayVC: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleNavBar()
        self.cardView.layer.cornerRadius = 10
        self.cardView.clipsToBounds = true
        
        if self.resultsArray.count != 0 {
            self.selectedEntry = resultsArray[self.index] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.showDiaryWithEntry(self.selectedEntry)
    }
    
    func styleNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }


    @IBAction func onLeftButtonPressed(sender: UIButton) {
        if self.index == 0 {
        } else {
            self.selectedEntry = resultsArray[self.index-1] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
            self.index = self.index - 1
        }
    }
    
    @IBAction func onRightButtonPressed(sender: UIButton) {
        if self.index == self.resultsArray.count-1 {
        } else {
            self.selectedEntry = resultsArray[self.index+1] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
            self.index = self.index + 1
        }
    }
    
    @IBAction func onDismissButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
        self.wordNumberLabel.text = numberOfWordsInEntry()
        self.timeTextLabel.text = self.selectedEntry.date?.time()

    }
    
    func numberOfWordsInEntry () -> String {
        let words = selectedEntry.text!.componentsSeparatedByString(" ") as Array
        
        if words.count == 1 {
            return "\(words.count) word"
        } else {
            return "\(words.count) words"
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let destVC = navigationController.topViewController as! AddOrEditVC // since we're going to a navigation controller
        
        destVC.moc = self.moc
        destVC.entryBeingEdited = self.selectedEntry
        
    }

}
