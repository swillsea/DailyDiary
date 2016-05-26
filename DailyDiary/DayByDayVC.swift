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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.resultsArray.count != 0 {
            self.selectedEntry = resultsArray[self.index] as! Entry
            self.showDiaryWithEntry(self.selectedEntry)
        } else {
            self.timeTextField.text = "May 18, 2016"
        }
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showDiaryWithEntry(entry:Entry) {
        let dateFormat = NSDateFormatter()
        dateFormat.dateStyle = .MediumStyle
        self.timeTextField.text = dateFormat.stringFromDate(entry.date!)
        if entry.imageData != nil {
            self.imageView.image = UIImage(data:entry.imageData!)
        } else {
            self.imageView.image = nil
        }
        self.textView.text = entry.text

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let destVC = navigationController.topViewController as! AddOrEditVC // since we're going to a navigation controller
        
        destVC.moc = self.moc
        destVC.currentEntry = self.selectedEntry
        
    }

}
