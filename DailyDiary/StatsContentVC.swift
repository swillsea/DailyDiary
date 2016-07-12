//
//  StatsContentVC.swift
//  Quotidian
//
//  Created by Sam on 7/12/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import JYGraphView

class StatsContentVC: UIViewController {

    @IBOutlet weak var monthGraph: JYGraphView!
    @IBOutlet weak var dayGraph: JYGraphView!
    
    @IBOutlet weak var statsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBasicStats()
        populateMonthGraph()
        populateDayGraph()
    }
    
    private func displayBasicStats(){
        statsLabel.text = "Total entries: 8" + "\n" + "Total words: 1,045" + "Avg words per entry: 303 " + "Entries in the last 30 days: 7"
    }
    
    private func populateMonthGraph(){
        let monthData = [1,3,4,5,7,2,4,5,6,2,3]
        let monthLabels = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
        styleGraph(monthGraph, with: monthData, and: monthLabels)
    }
    
    private func populateDayGraph(){
        let dayData = [0, 0, 0, 3, 4, 2, 1]
        let dayLabels = ["MON", "TUES", "WED", "THUR", "FRI", "SAT", "SUN"]
        styleGraph(dayGraph, with: dayData, and: dayLabels)
    }
    
    private func styleGraph(graph: JYGraphView, with data: [Int], and labelData: [String]){
        graph.graphData = data
        graph.graphDataLabels = labelData
        graph.strokeColor = UIColor.init(red: 243/250, green: 40/250, blue: 2/250, alpha: 1.0)
        graph.hidePoints = true
        graph.hideLabels = false
        graph.useCurvedLine = true
        graph.graphWidth = UInt(labelData.count * 42)
        graph.barColor = UIColor.clearColor()
        graph.labelBackgroundColor = UIColor.clearColor()
        graph.backgroundViewColor = UIColor.clearColor()
        graph.clipsToBounds = true
        graph.plotGraphData()
//      interfaceGroup.setBackgroundImage(graph.graphImage) //Useful for AppleWatch GraphImage generation
    }

}
