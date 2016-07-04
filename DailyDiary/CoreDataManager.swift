//
//  CoreDataManager.swift
//  instaclone
//
//  Created by Sam on 4/12/16.
//  Copyright © 2016 Michael Merrill. All rights reserved.
//
import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let sharedInstance = CoreDataManager()
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var entryResultsController: NSFetchedResultsController!
    
    // MARK: CoreData Fetch
    func fetchCoreData() -> NSFetchedResultsController {
        
        let fetchRequest             = NSFetchRequest(entityName: "Entry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        entryResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: moc,
                                                      sectionNameKeyPath: nil,
                                                               cacheName: "AllData")
        do {
            try entryResultsController.performFetch()
                
                //If fetch is empty, load test data
                //if entryResultsController.fetchedObjects?.count == 0 {
                //self.addTestData() - this method only exists in the testing branch so as not to ever accidently push to the app store
                //}
            
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return entryResultsController
    }

}