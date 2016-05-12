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
    
    weak var entry : Entry?{
        didSet {
            if entry?.imageData != nil {
                imageView.image = UIImage(data: (entry?.imageData!)!)
            }
            entryLabel.text = entry!.text
            monthLabel.text = "Jun"
            dayLabel.text = "10"
            timeAgoLabel.text = entry!.date!.timeAsString()
            
        }
    }
}
