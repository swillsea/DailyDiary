//
//  String+Extension.swift
//  Quotidian
//
//  Created by Sam on 5/27/16.
//  Copyright © 2016 Sam Willsea, Pei Xiong, and Michael Merrill. All rights reserved.
//

import Foundation

extension NSString {
    
    func asWordCountString()-> String {
       
        let words = self.componentsSeparatedByString(" ") as Array
        var wordsOnly = []
        
        for string in words {
            if string != "" {
                wordsOnly = wordsOnly.arrayByAddingObject(string)
            }
        }

        if wordsOnly.count == 1 {
            return "\(wordsOnly.count) word"
        } else if wordsOnly.count == 0 {
            return "No words"
        } else {
            return "\(wordsOnly.count) words"
        }
    }
}