//
//  ChartView.swift
//  HealthAssistant
//
//  Created by Арсений on 21.04.24.
//

import Foundation
import UIKit
import DGCharts

final class Chart {
    
    lazy var view: LineChartView = {
        let chartView = LineChartView()
        chartView.rightAxis.enabled = true
        chartView.leftAxis.enabled = true
        chartView.leftAxis.labelTextColor = .white
        chartView.leftAxis.axisLineColor = .white
        chartView.drawGridBackgroundEnabled = true
        chartView.xAxis.enabled = true
        chartView.legend.enabled = true
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = true
        return chartView
    }()
    
    private var arrayValues = [ChartDataEntry]()
    private var dataSet = LineChartDataSet()
        
    public func setupChart(with_ arrayValues: [Double]){
        dataSet = LineChartDataSet(entries: makeArrayEntriesFromValues(from: arrayValues))
        dataSet.drawCirclesEnabled = true
        dataSet.drawValuesEnabled = true
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.colors = [UIColor.white]
        dataSet.drawHorizontalHighlightIndicatorEnabled = true
        dataSet.drawVerticalHighlightIndicatorEnabled = false
    }
    
    private func makeArrayEntriesFromValues(from values: [Double]) -> [ChartDataEntry] {
        var arrayEntries: [ChartDataEntry] = []
        var i = 0
        for value in values {
            let entry = ChartDataEntry(x: Double(i), y: value)
            arrayEntries.append(entry)
            i += 1
        }
        return arrayEntries
    }
}
