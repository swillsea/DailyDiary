//
//  GridCell.swift
//  Quotidian
//
//  Created by Sam on 5/9/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    weak var entry : Entry?{
        didSet {
            if entry?.imageData != nil{
                imageView.image = UIImage(data: (entry?.imageData!)!)
                
            } else {
                imageView.image = nil;
                imageView.backgroundColor = UIColor.init(colorLiteralRed: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
            }
            
            self.imageView.layer.cornerRadius = 4
            self.imageView.clipsToBounds = true
            
        }
    }
}
