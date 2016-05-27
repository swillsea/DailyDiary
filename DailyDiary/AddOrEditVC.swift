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
        self.styleNavBar()
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation:UIStatusBarAnimation.Fade)
        displayCorrectEntry()
        entryText.becomeFirstResponder()
    }
    
    func styleNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let newNavBar = UINavigationBar.init(frame:(CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)))
        let newItem = UINavigationItem()
        
        let addImageButtonImage = UIImage.init(named:"camera")
        let addImageBarButtonItem = UIBarButtonItem.init(image: addImageButtonImage, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.addImage))
        
        let doneBarButtonItem = UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.backTapped))
        
        // the bar button item is actually set on the navigation item, not the navigation bar itself.
        newItem.rightBarButtonItem = addImageBarButtonItem
        newItem.leftBarButtonItem = doneBarButtonItem
        newNavBar.setItems([newItem], animated: false)
        self.view.addSubview(newNavBar)
    }
    
    func backTapped (){
        if (self.entryText.text.characters.count > 0 || self.entryImageView.image != nil){
            saveOrUpdate()
        }
        self.entryText.resignFirstResponder()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func displayCorrectEntry(){
        if entryBeingEdited != nil {
            displayEntryDate(entryBeingEdited.date!)
            self.entryText.text = self.entryBeingEdited.text
            if entryBeingEdited.imageData != nil{
                self.entryImageView.image = UIImage.init(data: self.entryBeingEdited.imageData!)
                textViewBottomConstraint.constant = 10
            } else {
                textViewBottomConstraint.constant = -60
            }
        } else {
            let today = NSDate()
            displayEntryDate(today)
            textViewBottomConstraint.constant = -60
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
    
    func addImage() {
        if self.entryImageView.image != nil {
            promptForReplaceImage()
        } else {
            promptForImageSource()
        }
    }
    
    @IBAction func onAddImageButtonPressed(sender: UIBarButtonItem) {

    }
    
    func promptForReplaceImage(){
        let prompt = UIAlertController(title:nil, message:nil, preferredStyle: .ActionSheet)
        
        let continueToReplace = UIAlertAction(title: "Replace current image", style: .Default) { (alert:UIAlertAction!) -> Void in
            self.promptForImageSource()
        }
        
        let removeImage = UIAlertAction(title: "Remove image", style: .Destructive) { (alert:UIAlertAction!) -> Void in
            self.entryImageView.image = nil
            self.textViewBottomConstraint.constant = -60
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.entryImageView.image = image
        textViewBottomConstraint.constant = 10
        self.dismissViewControllerAnimated(true, completion: nil)
        entryText.becomeFirstResponder()
    }
    
}
