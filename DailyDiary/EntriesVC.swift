//
//  EntriesVC.swift
//  Quotidian
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import UIKit
import CoreData


class EntriesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate{
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layoutButton: UIBarButtonItem!
    private var viewIsListLayout = true
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    private var entryResultsController: NSFetchedResultsController!
    private var resultsArray : [NSManagedObject]!
    private var sectionChanges = NSMutableArray()
    private var itemChanges = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation:UIStatusBarAnimation.None)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        prepareForCollectionView()
        self.collectionView.reloadData()
    }
    
    private func prepareForCollectionView() {
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
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let footerview = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", forIndexPath: indexPath)
        return footerview

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if resultsArray != nil && resultsArray.count == 0 {
            return CGSizeMake(collectionView.frame.width, 185)
        } else {
            return CGSizeMake(0, 0)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var collectionViewWidth : CGFloat = 30.0
        if collectionView.frame.size.width > 30 {
            collectionViewWidth = self.collectionView.frame.size.width //we need to use a constant so that in viewWillAppear the status bar changing doesn't cause layout problems when reloading collectionView
        }
        if viewIsListLayout {
            return CGSize(width: (collectionViewWidth-20), height: 75)
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
    
    @IBAction private func onLayoutButtonPressed(sender: UIBarButtonItem) {
        
        if (viewIsListLayout) {
            self.layoutButton.image = UIImage.init(named:"list")
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            viewIsListLayout = false
        } else {
            self.layoutButton.image = UIImage.init(named:"grid")
            self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
            self.collectionView.setContentOffset(CGPoint.init(x: 0, y: -10), animated: false)

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
            let destVC = segue.destinationViewController as! AddOrEditVC // since we're going to a navigation controller
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
