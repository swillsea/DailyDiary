//
//  String+Extension.swift
//  DailyDiary
//
//  Created by Sam on 5/27/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import Foundation

extension NSString {
    
    func asWordCountString()-> String {
        let words = self.componentsSeparatedByString(" ") as Array
        
        if (words.count == 1) && (words[0].characters.count < 0) {
            return "\(words.count) word"
        } else if words.count == 1 {
            return "No words"
        } else {
            return "\(words.count) words"
        }
    }
}