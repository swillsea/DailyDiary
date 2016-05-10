//
//  Date+Extension.swift
//  instaclone
//
//  Created by Sam on 4/9/16.
//  Copyright © 2016 Michael Merrill. All rights reserved.
//

import Foundation

extension NSDate {
    
    func timeAsString () -> String {
        
        var displayDate = ""
        let timeSinceTaken = NSDate().timeIntervalSinceDate(self)
        
        let aSecond            : Double = 1
        let aSecondWhenRounded : Double = aSecond * 1.5
        let aMinute            : Double = 60.0
        let anHour             : Double = 60.0 * aMinute
        let aDay               : Double = 24.0 * anHour
                
        if timeSinceTaken < aSecondWhenRounded {
            
            displayDate = String(format: "One second ago")
        
        } else if timeSinceTaken < aMinute {
            
            displayDate = String(format: "%.0f seconds ago", timeSinceTaken)
            
        } else if timeSinceTaken < 2 * aMinute {
            
            displayDate = String(format: "One minute ago")
        
        } else if timeSinceTaken < anHour {
            
            displayDate = String(format: "%.0f minutes ago", (timeSinceTaken/60) )
        
        } else if timeSinceTaken < 2 * anHour {
            
            displayDate = String(format: "One hour ago")
            
        } else if timeSinceTaken < aDay {
            
            displayDate = String(format: "%.0f hours ago", (timeSinceTaken/3600) )
            
        } else {
            //returns the day of year if taken longer than a day ago
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            dateFormatter.timeStyle = .NoStyle
            
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
            displayDate = "\(dateFormatter.stringFromDate(self))"
        }
        
        return displayDate
        
    }
    
}
