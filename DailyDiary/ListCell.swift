//
//  ListCell.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var timeAgoLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var entryLabelLeadingConstraint: NSLayoutConstraint!
    
    weak var entry : Entry?{
        didSet {
            if entry?.imageData != nil {
                imageView.image = UIImage(data: (entry?.imageData!)!)
                
                timeAgoLabelLeadingConstraint.constant = 10
                entryLabelLeadingConstraint.constant   = 10
                
            } else {
                timeAgoLabelLeadingConstraint.constant = -imageView.frame.width + 10
                entryLabelLeadingConstraint.constant   = -imageView.frame.width + 10
            }
            entryLabel.text = entry!.text
            monthLabel.text = "Jun"
            dayLabel.text = "10"
            let timeSinceCreated = entry!.date!.timeAsString()
            self.timeAgoLabel.text = timeSinceCreated + "       " + "\(numberOfWordsInEntry())"
            self.layer.cornerRadius = 4
            self.clipsToBounds = true
        }
    }
    
    func numberOfWordsInEntry () -> String {
        let words = entry!.text!.componentsSeparatedByString(" ") as Array
        
        if words.count == 1 {
            return "\(words.count) word"
        } else {
           return "\(words.count) words"
        }
    }
}
