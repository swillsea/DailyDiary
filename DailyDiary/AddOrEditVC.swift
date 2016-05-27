//
//  AddOrEditVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import UIKit
import CoreData

class AddOrEditVC: UIViewController, UIActionSheetDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var entryText: UITextView!
    @IBOutlet weak var entryImageView: UIImageView!
    var doneEditing = false
    var moc: NSManagedObjectContext!
    var entryBeingEdited: Entry!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!

//MARK: View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCorrectEntry()
        entryText.becomeFirstResponder()
    }
    
    func displayCorrectEntry(){
        if entryBeingEdited != nil {
            displayEntryDate(entryBeingEdited.date!)
            self.entryText.text = self.entryBeingEdited.text
            if entryBeingEdited.imageData != nil{
                self.entryImageView.image = UIImage.init(data: self.entryBeingEdited.imageData!)
                textViewBottomConstraint.constant = 10
            }
        } else {
            let today = NSDate()
            displayEntryDate(today)
            textViewBottomConstraint.constant = 10-imageHeightConstraint.constant
        }
    }
    
    func displayEntryDate(date: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        self.title = dateFormatter.stringFromDate(date)
    }
       
//MARK: CoreData Interactions
    func saveOrUpdate() {
        if entryBeingEdited != nil { updateEntry() }
        else { saveNewEntry() }
        
        do { try self.moc.save() }
        catch let error as NSError {
            print("Error saving to CoreData \(error)")
        }
    }
    
    func updateEntry() {
        entryBeingEdited.text = self.entryText.text
        if (self.entryImageView.image != nil){
            entryBeingEdited.imageData = UIImageJPEGRepresentation(self.entryImageView.image!, 1)
        }
    }
    
    func saveNewEntry() {
        let newEntry = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        newEntry.text = self.entryText.text
        newEntry.date = NSDate()
        newEntry.location = ""
        if (self.entryImageView.image != nil){
            newEntry.imageData = UIImageJPEGRepresentation(self.entryImageView.image!, 1)
        } else {
            newEntry.imageData = UIImageJPEGRepresentation(UIImage(), 0)
        }
        entryBeingEdited = newEntry
    }

//MARK: Actions
    
    @IBAction func onAddImageButtonPressed(sender: UIBarButtonItem) {
        if self.entryImageView.image != nil {
            promptForReplaceImage()
        } else {
            promptForImageSource()
        }
    }
    
    func promptForReplaceImage(){
        let prompt = UIAlertController(title:nil, message:nil, preferredStyle: .ActionSheet)
        
        let continueToReplace = UIAlertAction(title: "Replace current image", style: .Default) { (alert:UIAlertAction!) -> Void in
            self.promptForImageSource()
        }
        
        let removeImage = UIAlertAction(title: "Remove image", style: .Destructive) { (alert:UIAlertAction!) -> Void in
            self.entryImageView.image = nil
            self.textViewBottomConstraint.constant = 10-self.imageHeightConstraint.constant
            if self.entryBeingEdited != nil {
                self.entryBeingEdited.imageData = UIImageJPEGRepresentation(UIImage(), 0)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        prompt.addAction(continueToReplace)
        prompt.addAction(removeImage)
        prompt.addAction(cancel)
        presentViewController(prompt, animated: true, completion:nil)
    }
    
    func promptForImageSource(){
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
    
    
    @IBAction func onBackButtonPressed(sender: UIBarButtonItem) {
        if (self.entryText.text.characters.count > 0 || self.entryImageView.image != nil){
            saveOrUpdate()
        }
        self.entryText.resignFirstResponder()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.entryImageView.image = image
        textViewBottomConstraint.constant = 10
        self.dismissViewControllerAnimated(true, completion: nil)
        entryText.becomeFirstResponder()
    }
    
}
