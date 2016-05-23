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
                
            } else {
                imageView.image = nil;
                imageView.backgroundColor = UIColor.init(colorLiteralRed: 168/255, green: 196/255, blue: 199/255, alpha: 1.0)
            }
            
            self.imageView.layer.cornerRadius = 20
            self.imageView.clipsToBounds = true
            
        }
    }
}
