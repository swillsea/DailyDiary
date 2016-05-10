//
//  AddOrEditVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit

class AddOrEditVC: UIViewController, UIActionSheetDelegate, UITextViewDelegate {

    @IBOutlet weak var entryText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        entryText.becomeFirstResponder()
    }

    @IBAction func onCameraButtonPressed(sender: UIBarButtonItem) {
        
        let prompt = UIAlertController(title:nil, message:nil, preferredStyle: .ActionSheet)
        let firstAction = UIAlertAction(title: "Use Camera", style: .Default) { (alert: UIAlertAction!) -> Void in
            //launch cameraVC
        }
        let secondAction = UIAlertAction(title: "Choose from Library", style: .Default) { (alert: UIAlertAction!) -> Void in
            //launch importVC
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (alert: UIAlertAction) in
            //do nothing
        }
        prompt.addAction(firstAction)
        prompt.addAction(secondAction)
        prompt.addAction(cancel)
        presentViewController(prompt, animated: true, completion:nil)
    }
    
}
