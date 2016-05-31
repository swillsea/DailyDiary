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
            
        } else if timeSinceTaken < 2 * aDay {

            displayDate = String(format: "One day ago")

        } else {
            
            displayDate = String(format: "%.0f days ago", (timeSinceTaken/86400) )

        }
        
        return displayDate
        
    }
    
    func time() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm aa"
        let time = dateFormatter.stringFromDate(self)
        
        return time
    }
    
    func month() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM"
        let month = dateFormatter.stringFromDate(self)
        return month
    }
    
    func day() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.stringFromDate(self)
        return day
    }
    
}
