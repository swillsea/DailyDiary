//
//  EntriesVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
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
    var sectionChanges = NSMutableArray()
    var itemChanges = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
            self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
            viewIsListLayout = false
        } else {
            self.layoutButton.image = UIImage.init(named:"grid")
            self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
            viewIsListLayout = true
        }
        
        self.collectionView.reloadData()        
    }
    
//MARK: Required to use NSFetchedResultsController with UICollectionView
    func controller(controller: NSFetchedResultsController, didChangeSection
        sectionInfo: NSFetchedResultsSectionInfo, atIndex
        sectionIndex: Int, forChangeType
        type: NSFetchedResultsChangeType) {
        
        let change = NSMutableDictionary()
        change.setObject(sectionIndex, forKey:"type")
        sectionChanges.addObject(change)
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                       atIndexPath indexPath: NSIndexPath?,
                          forChangeType type: NSFetchedResultsChangeType,
                                newIndexPath: NSIndexPath?) {
        
        let change = NSMutableDictionary()
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            change.setObject(newIndexPath!, forKey:"type")
            break;
        case NSFetchedResultsChangeType.Delete:
            change.setObject(indexPath!, forKey:"type")
            break;
        case NSFetchedResultsChangeType.Update:
            change.setObject(indexPath!, forKey:"type")
            break;
        case NSFetchedResultsChangeType.Move:
            change.setObject([indexPath!, newIndexPath!], forKey:"type")
            break;
        }
        itemChanges .addObject(change)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.collectionView.performBatchUpdates({
            
            for change in self.sectionChanges {
                change.enumerateKeysAndObjectsUsingBlock({ (key, obj, stop) in
                    switch key {
                    case NSFetchedResultsChangeType.Insert:
                        self.collectionView.insertSections(NSIndexSet.init(indexSet: obj as! NSIndexSet))
                        break;
                    case NSFetchedResultsChangeType.Delete:
                        self.collectionView.deleteSections(NSIndexSet.init(indexSet: obj as! NSIndexSet))
                        break;
                    default:
                        break;
                    }
                })
            }
            
            for change in self.itemChanges {
                change.enumerateKeysAndObjectsUsingBlock({ (key, obj, stop) in
                    switch key {
                    case NSFetchedResultsChangeType.Insert:
                        self.collectionView.insertItemsAtIndexPaths([obj as! NSIndexPath])
                        break;
                    case NSFetchedResultsChangeType.Delete:
                        self.collectionView.deleteItemsAtIndexPaths([obj as! NSIndexPath])
                        break;
                    case NSFetchedResultsChangeType.Update:
                        self.collectionView.reloadItemsAtIndexPaths([obj as! NSIndexPath])
                        break;
                    case NSFetchedResultsChangeType.Move:
                        self.collectionView.moveItemAtIndexPath(obj.objectAtIndex(0) as! NSIndexPath, toIndexPath: obj.objectAtIndex(1) as! NSIndexPath)
                        break;
                    default:
                        break;
                    }
                })
            }
            
        }) { (Bool) in
            self.sectionChanges.removeAllObjects()
            self.itemChanges.removeAllObjects()
        }
    }
    
// MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toAddNew" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let destVC = navigationController.topViewController as! AddOrEditVC // since we're going to a navigation controller

            destVC.moc = self.moc
            
        } else if segue.identifier == "toDayView" {
            let destVC = segue.destinationViewController as! DayByDayVC
            destVC.resultsArray = resultsArray
            let indexpath = self.collectionView.indexPathsForSelectedItems()![0]
            //let entry = resultsArray[indexpath.row] as! Entry
            destVC.index = indexpath.row
            destVC.moc = self.moc
        }
    }
}
