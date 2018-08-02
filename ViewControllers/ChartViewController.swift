//
//  ChartViewController.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Created by Jacky Huynh on 2018-07-27.
//
// Bugs(fixed): PieChart would not be displayed, data would not be properly transferred to the variables so app would crash went entering this viewController


import UIKit
import Charts

class ChartViewController: UIViewController {

    // gets the total weight of all the ingredients users have saved
    var total_weight = Shared.shared.veg_weight_total + Shared.shared.grain_weight_total + Shared.shared.meat_weight_total
    
    // initializes the different sections of the pie chart
    var veg_chart = PieChartDataEntry(value: 0)
    var grain_chart = PieChartDataEntry(value: 0)
    var meat_chart = PieChartDataEntry(value: 0)
    
    // Data will be stored in here
    var plateData = [PieChartDataEntry]()
 
    // chart object
    @IBOutlet var pieChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // calculates the data to be entered in for the different sections in the chart
        let veg_entry = (Shared.shared.veg_weight_total / total_weight) * 100
        let grain_entry = (Shared.shared.grain_weight_total / total_weight) * 100
        let meat_entry = (Shared.shared.meat_weight_total / total_weight) * 100
        
        // the calculated data
        veg_chart = PieChartDataEntry(value: veg_entry, label: "Vegetables")
        grain_chart = PieChartDataEntry(value: grain_entry, label: "Grains")
        meat_chart = PieChartDataEntry(value: meat_entry, label: "Meat & Alternatives")
        // assigning to the plate
        plateData = [veg_chart, grain_chart, meat_chart]
        // creates the chart
        updateChartData()
        
        // setting some properties for the chart
        pieChart.chartDescription?.text = ""
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        pieChart.drawHoleEnabled = false
        pieChart.legend.enabled = false
        
    }
    
    // Creates/updates the chart
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: plateData, label: "Food Groups")
        let chartData = PieChartData(dataSet: chartDataSet)
        let colours = [UIColor(named: "veg_colour"), UIColor(named: "grain_colour"), UIColor(named: "meat_colour")]
        
        chartDataSet.colors = colours as! [NSUIColor]
        pieChart.data = chartData
        
    }
    
    
}
