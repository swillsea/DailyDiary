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
    
        entryResultsController = CoreDataManager.sharedInstance.fetchCoreData()
        entryResultsController.delegate = self
        resultsArray = entryResultsController.fetchedObjects! as! [NSManagedObject]

    }

    override func viewWillAppear(animated: Bool) {
        resultsArray = entryResultsController.fetchedObjects! as! [NSManagedObject]
        self.collectionView.reloadData()
    }


// MARK: CollectionViewLayout
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (resultsArray != nil) { return resultsArray.count }
        else { return 0 }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width

        if viewIsListLayout {
            return CGSize(width: collectionViewWidth, height: 75)
        } else {
            return CGSize(width: collectionViewWidth/2, height: collectionViewWidth/2)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if viewIsListLayout {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listCell", forIndexPath: indexPath) as! ListCell
            let e = resultsArray[indexPath.row] as! Entry
            if  (e.imageData != nil) {
            cell.imageView.image = UIImage(data: e.imageData!)
            }
            cell.dayLabel.text = e.date!.timeAsString()
            cell.entryLabel.text = e.text!
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gridCell", forIndexPath: indexPath) as! GridCell
            let e = resultsArray[indexPath.row] as! Entry
            if  (e.imageData != nil) {
                cell.imageView.image = UIImage(data: e.imageData!)
            }
            return cell
        }
    }
    
    @IBAction func onLayoutButtonPressed(sender: UIBarButtonItem) {
        
        if (viewIsListLayout) {
            self.layoutButton.image = UIImage.init(named:"list")
            viewIsListLayout = false
            collectionView.reloadData()
        } else {
            self.layoutButton.image = UIImage.init(named:"grid")
            viewIsListLayout = true
            collectionView.reloadData()
        }
    }
    
    

// MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "toAddNew" {
        let destVC = segue.destinationViewController as! AddOrEditVC
        destVC.moc = self.moc
        }
        
    }


}
