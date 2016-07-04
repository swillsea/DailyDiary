//
//  ListCell.swift
//  Quotidian
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var entryLabel: UILabel!
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var timeAgoLabel: UILabel!
    @IBOutlet private weak var timeAgoLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var entryLabelLeadingConstraint: NSLayoutConstraint!
    
    weak var entry : Entry?{
        didSet {
            styleCorners()
            displayLabelText()
            checkIfImageExists()
        }
    }
    
    private func styleCorners() {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    private func displayLabelText() {
        entryLabel.text = entry!.text
        monthLabel.text = entry!.date!.month().uppercaseString
        dayLabel.text = entry!.date!.day()
        timeAgoLabel.text = "\(entry!.text!.asWordCountString())"
        // let timeSinceCreated = entry!.date!.timeAsString()
    }
    
    private func checkIfImageExists() {
        if entry?.imageData != nil {
            setViewWhenNoImageExists()
        } else {
            setViewWhenImageExists()
        }
    }
    
    private func setViewWhenNoImageExists() {
        imageView.image = UIImage(data: (entry?.imageData!)!)
        
        timeAgoLabelLeadingConstraint.constant = 10
        entryLabelLeadingConstraint.constant   = 10
    }
    
    private func setViewWhenImageExists() {
        imageView.image = nil;
        
        timeAgoLabelLeadingConstraint.constant = -imageView.frame.width + 10
        entryLabelLeadingConstraint.constant   = -imageView.frame.width + 10
    }
}
