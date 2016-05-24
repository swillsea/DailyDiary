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
    //var selectedEntry: Entry!
    var index:NSInteger!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.resultsArray.count != 0 {
            let entry = resultsArray[self.index] as! Entry
            self.showDiaryWithEntry(entry)
        } else {
            self.timeTextField.text = "May 18, 2016"
        }
    }

    @IBAction func onLeftButtonPressed(sender: UIButton) {
        if self.index == 0 {
        } else {
            let entry = resultsArray[self.index-1] as! Entry
            self.showDiaryWithEntry(entry)
            self.index = self.index - 1
        }
    }
    
    @IBAction func onRightButtonPressed(sender: UIButton) {
        if self.index == self.resultsArray.count-1 {
        } else {
            let entry = resultsArray[self.index+1] as! Entry
            self.showDiaryWithEntry(entry)
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

}
