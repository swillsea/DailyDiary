//
//  EntriesVC.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit

class EntriesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layoutButton: UIBarButtonItem!
    var viewIsListLayout = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



// MARK: CollectionViewLayout
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width

        if viewIsListLayout {
            return CGSize(width: collectionViewWidth, height: 75)
        } else {
            return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if viewIsListLayout {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listCell", forIndexPath: indexPath) as! ListCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gridCell", forIndexPath: indexPath) as! GridCell
            return cell
        }
    }
    
    @IBAction func onLayoutButtonPressed(sender: UIBarButtonItem) {
        
        if (viewIsListLayout) {
            self.layoutButton.image = UIImage.init(named:"grid")
            collectionView.reloadData()
            viewIsListLayout = false
        } else {
            self.layoutButton.image = UIImage.init(named:"list")
            viewIsListLayout = true
            collectionView.reloadData()
        }
    }
    
    

// MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }


}
