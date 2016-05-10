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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryText.becomeFirstResponder()
    }

    @IBAction func onCameraButtonPressed(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate      = self
        imagePicker.allowsEditing = true
        
        let prompt = UIAlertController(title:nil, message:nil, preferredStyle: .ActionSheet)
        let firstAction = UIAlertAction(title: "Use Camera", style: .Default) { (alert: UIAlertAction!) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
            }

        }
        let secondAction = UIAlertAction(title: "Choose from Library", style: .Default) { (alert: UIAlertAction!) -> Void in
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)

        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (alert: UIAlertAction) in
            //do nothing
        }
        prompt.addAction(firstAction)
        prompt.addAction(secondAction)
        prompt.addAction(cancel)
        presentViewController(prompt, animated: true, completion:nil)
        

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.entryImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        entryText.becomeFirstResponder()
    }

}
