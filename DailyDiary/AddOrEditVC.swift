//
//  AddOrEditVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import CoreData

class AddOrEditVC: UIViewController, UIActionSheetDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
 
    @IBOutlet weak var entryText: UITextView!
    @IBOutlet weak var entryImageView: UIImageView!
    var doneEditing = false
    var moc: NSManagedObjectContext!
    var newEntry: Entry!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryText.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("Error saving to CoreData \(error)")
        }
    }
    
    @IBAction func onAddImagePressed(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate      = self
        imagePicker.allowsEditing = true
        
        let prompt = UIAlertController(title:nil, message:nil, preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Use Camera", style: .Default) { (alert: UIAlertAction!) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            
        }
        
        let libraryAction = UIAlertAction(title: "Choose from Library", style: .Default) { (alert: UIAlertAction!) -> Void in
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (alert: UIAlertAction) in }
        
        prompt.addAction(cameraAction)
        prompt.addAction(libraryAction)
        prompt.addAction(cancel)
        presentViewController(prompt, animated: true, completion:nil)
        

    }

    @IBAction func onEditButtonPressed(sender: UIBarButtonItem) {
        if !doneEditing {
            self.navigationItem.rightBarButtonItem!.title = "Edit"
            entryText.resignFirstResponder()

            
            if (self.entryImageView.image != nil){
                newEntry.imageData = UIImageJPEGRepresentation(self.entryImageView.image!, 1)
                self.imageHeightConstraint.constant = self.view.frame.width
                self.textViewBottomConstraint.constant = 20


            } else {
                newEntry.imageData = UIImageJPEGRepresentation(UIImage(), 0)
            }
            
            newEntry.text = self.entryText.text
            
        } else {
            self.navigationItem.rightBarButtonItem!.title = "Done"
            entryText.becomeFirstResponder()
            self.imageHeightConstraint.constant = 50
            self.textViewBottomConstraint.constant = 260

        }
        doneEditing = !doneEditing
    }
    

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.entryImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        entryText.becomeFirstResponder()
    }

}
