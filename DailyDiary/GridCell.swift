//
//  GridCell.swift
//  DailyDiary
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    weak var entry : Entry?{
        didSet {
            if entry?.imageData != nil{
                
                imageView.image = UIImage(data: (entry?.imageData!)!)
                
                self.layer.cornerRadius = 4
                self.clipsToBounds = true
            }
            
        }
    }
}
