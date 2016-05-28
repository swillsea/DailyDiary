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
                
//              If fetch is empty, load test data
                if entryResultsController.fetchedObjects?.count == 0 {
                    self.addTestData()
                }
            
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return entryResultsController
    }
    
    private func addTestData() {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM d, y hh:mm aa"
        
        let newItem  = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem2 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem3 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem4 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem5 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem6 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem7 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        let newItem8 = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: self.moc) as! Entry
        
        newItem.date         = dateFormatter.dateFromString("May 3, 2016 06:22 PM")
        newItem.text         = "Tradesmen called for custom, and I promised Farmerson, the ironmonger, to give him a turn if I wanted any nails or tools.  By-the-by, that reminds me there is no key to our bedroom door, and the bells must be seen to.  The parlour bell is broken, and the front door rings up in the servant’s bedroom, which is ridiculous.  Dear friend Gowing dropped in, but wouldn’t stay, saying there was an infernal smell of paint."
        newItem.imageData    = UIImagePNGRepresentation(UIImage.init(named: "save1")!)
        newItem.location     = ""
        
        newItem2.date        = dateFormatter.dateFromString("May 4, 2016 08:22 PM")
        newItem2.text        = "Tradesmen still calling; Carrie being out, I arranged to deal with Horwin, who seemed a civil butcher with a nice clean shop.  Ordered a shoulder of mutton for to-morrow, to give him a trial.  Carrie arranged with Borset, the butterman, and ordered a pound of fresh butter, and a pound and a half of salt ditto for kitchen, and a shilling’s worth of eggs.  In the evening, Cummings unexpectedly dropped in to show me a meerschaum pipe he had won in a raffle in the City, and told me to handle it carefully, as it would spoil the colouring if the hand was moist.  He said he wouldn’t stay, as he didn’t care much for the smell of the paint, and fell over the scraper as he went out.  Must get the scraper removed, or else I shall get into a scrape.  I don’t often make jokes."
        newItem2.imageData   = UIImagePNGRepresentation(UIImage.init(named: "save2")!)
        newItem2.location    = ""
        
        newItem3.date        = dateFormatter.dateFromString("May 5, 2016 03:52 PM")
        newItem3.text        = "Sometimes you just want to visit the seashore. It's days like this that I'm glad I have a camera in my pocket whenever the mood strikes.\n\nYou know what? I forgot to add a photo to this entry."
        newItem3.imageData   = nil
        newItem3.location    = ""
        
        newItem4.date        = dateFormatter.dateFromString("May 6, 2016 07:26 AM")
        newItem4.text        = "Eggs for breakfast simply shocking; sent them back to Borset with my compliments, and he needn’t call any more for orders.  Couldn’t find umbrella, and though it was pouring with rain, had to go without it.  Sarah said Mr. Gowing must have took it by mistake last night, as there was a stick in the ‘all that didn’t belong to nobody.  In the evening, hearing someone talking in a loud voice to the servant in the downstairs hall, I went out to see who it was, and was surprised to find it was Borset, the butterman, who was both drunk and offensive.  Borset, on seeing me, said he would be hanged if he would ever serve City clerks any more—the game wasn’t worth the candle.  I restrained my feelings, and quietly remarked that I thought it was possible for a city clerk to be a gentleman.  He replied he was very glad to hear it, and wanted to know whether I had ever come across one, for he hadn’t.  He left the house, slamming the door after him, which nearly broke the fanlight; and I heard him fall over the scraper, which made me feel glad I hadn’t removed it.  When he had gone, I thought of a splendid answer I ought to have given him.  However, I will keep it for another occasion."
        newItem4.imageData   = nil
        newItem4.location    = ""
        
        newItem5.date        = dateFormatter.dateFromString("May 7, 2016 10:01 PM")
        newItem5.text        = "Being Saturday, I looked forward to being home early, and putting a few things straight; but two of our principals at the office were absent through illness, and I did not get home till seven.  Found Borset waiting.  He had been three times during the day to apologise for his conduct last night.  He said he was unable to take his Bank Holiday last Monday, and took it last night instead.  He begged me to accept his apology, and a pound of fresh butter.  He seems, after all, a decent sort of fellow; so I gave him an order for some fresh eggs, with a request that on this occasion they should be fresh.  I am afraid we shall have to get some new stair-carpets after all; our old ones are not quite wide enough to meet the paint on either side.  Carrie suggests that we might ourselves broaden the paint.  I will see if we can match the colour (dark chocolate) on Monday."
        newItem5.imageData   = UIImagePNGRepresentation(UIImage.init(named: "save3")!)
        newItem5.location    = ""
        
        newItem6.date        = dateFormatter.dateFromString("May 8, 2016 011:22 AM")
        newItem6.text        = "After Church, the Curate came back with us.  I sent Carrie in to open front door, which we do not use except on special occasions.  She could not get it open, and after all my display, I had to take the Curate (whose name, by-the-by, I did not catch,) round the side entrance.  He caught his foot in the scraper, and tore the bottom of his trousers.  Most annoying, as Carrie could not well offer to repair them on a Sunday.  After dinner, went to sleep.  Took a walk round the garden, and discovered a beautiful spot for sowing mustard-and-cress and radishes.  Went to Church again in the evening: walked back with the Curate.  Carrie noticed he had got on the same pair of trousers, only repaired.  He wants me to take round the plate, which I think a great compliment."
        newItem6.imageData   = UIImagePNGRepresentation(UIImage.init(named: "save4")!)
        newItem6.location    = ""
        
        newItem7.date        = dateFormatter.dateFromString("May 9, 2016 01:56 PM")
        newItem7.text        = "Commenced the morning badly.  The butcher, whom we decided not to arrange with, called and blackguarded me in the most uncalled-for manner.  He began by abusing me, and saying he did not want my custom.  I simply said: “Then what are you making all this fuss about it for?”  And he shouted out at the top of his voice, so that all the neighbours could hear: “Pah! go along.  Ugh!  I could buy up ‘things’ like you by the dozen!\n\nI shut the door, and was giving Carrie to understand that this disgraceful scene was entirely her fault, when there was a violent kicking at the door, enough to break the panels.  It was the blackguard butcher again, who said he had cut his foot over the scraper, and would immediately bring an action against me.  Called at Farmerson’s, the ironmonger, on my way to town, and gave him the job of moving the scraper and repairing the bells, thinking it scarcely worth while to trouble the landlord with such a trifling matter.\n\nArrived home tired and worried.  Mr. Putley, a painter and decorator, who had sent in a card, said he could not match the colour on the stairs, as it contained Indian carmine.  He said he spent half-a-day calling at warehouses to see if he could get it.  He suggested he should entirely repaint the stairs.  It would cost very little more; if he tried to match it, he could only make a bad job of it.  It would be more satisfactory to him and to us to have the work done properly.  I consented, but felt I had been talked over.  Planted some mustard-and-cress and radishes, and went to bed at nine."
        newItem7.imageData   = UIImagePNGRepresentation(UIImage.init(named: "save5")!)
        newItem7.location    = ""
        
        newItem8.date        = dateFormatter.dateFromString("May 10, 2016 08:12 PM")
        newItem8.text        = "Farmerson came round to attend to the scraper himself.  He seems a very civil fellow.  He says he does not usually conduct such small jobs personally, but for me he would do so.  I thanked him, and went to town.  It is disgraceful how late some of the young clerks are at arriving.  I told three of them that if Mr. Perkupp, the principal, heard of it, they might be discharged.\n\nPitt, a monkey of seventeen, who has only been with us six weeks, told me “to keep my hair on!”  I informed him I had had the honour of being in the firm twenty years, to which he insolently replied that I “looked it.”  I gave him an indignant look, and said: “I demand from you some respect, sir.”  He replied: “All right, go on demanding.”  I would not argue with him any further.  You cannot argue with people like that.  In the evening Gowing called, and repeated his complaint about the smell of paint.  Gowing is sometimes very tedious with his remarks, and not always cautious; and Carrie once very properly reminded him that she was present."
        newItem8.imageData   = nil
        newItem8.location    = ""
        
        do {
            try entryResultsController.performFetch()
        } catch let error as NSError {
            print("Error saving to CoreData \(error)")
        }
    }
    
    
}