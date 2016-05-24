//
//  EntriesVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import CoreData


class EntriesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layoutButton: UIBarButtonItem!
    var viewIsListLayout = true
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var entryResultsController: NSFetchedResultsController!
    var resultsArray : [NSManagedObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareForCollectionView()
    }

    override func viewDidAppear(animated: Bool) {
        resultsArray = entryResultsController.fetchedObjects! as! [NSManagedObject]
        self.collectionView.reloadData()
    }
    
    func prepareForCollectionView() {
        entryResultsController = CoreDataManager.sharedInstance.fetchCoreData()
        entryResultsController.delegate = self
        resultsArray = entryResultsController.fetchedObjects! as! [NSManagedObject]
        
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }


// MARK: CollectionViewLayout
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (resultsArray != nil) { return resultsArray.count }
        else { return 0 }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width
        if viewIsListLayout {
            return CGSize(width: collectionViewWidth-20, height: 75)
        } else {
            return CGSize(width: collectionViewWidth/2, height: collectionViewWidth/2)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if viewIsListLayout {
            return 10
        } else {
            return 0
        }
    }
        
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if viewIsListLayout {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listCell", forIndexPath: indexPath) as! ListCell
            cell.entry = entryResultsController.objectAtIndexPath(indexPath) as? Entry
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gridCell", forIndexPath: indexPath) as! GridCell
            cell.entry = entryResultsController.objectAtIndexPath(indexPath) as? Entry
            return cell
        }
    }
    
    @IBAction func onLayoutButtonPressed(sender: UIBarButtonItem) {
        
        if (viewIsListLayout) {
            self.layoutButton.image = UIImage.init(named:"list")
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            viewIsListLayout = false
            collectionView.reloadData()
        } else {
            self.layoutButton.image = UIImage.init(named:"grid")
            self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

            viewIsListLayout = true
            collectionView.reloadData()
        }
    }
    
    

// MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "toAddNew" {
            
            let destVC = segue.destinationViewController as! AddOrEditVC
            let newEntry = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
            newEntry.text = ""
            newEntry.date = NSDate()
            newEntry.location = ""
            newEntry.imageData = UIImageJPEGRepresentation(UIImage(), 0)

            destVC.newEntry = newEntry
            destVC.moc = self.moc

        } else if segue.identifier == "toEdit" {
            
        } else if segue.identifier == "toDayView" {
            let destVC = segue.destinationViewController as! DayByDayVC
            destVC.resultsArray = resultsArray
            let indexpath = self.collectionView.indexPathsForSelectedItems()![0]
            //let entry = resultsArray[indexpath.row] as! Entry
            destVC.index = indexpath.row
        }
    }


}
