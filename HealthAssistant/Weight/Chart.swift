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
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = true
        chartView.leftAxis.labelTextColor = .white
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 15, weight: .medium)
//        chartView.leftAxis.labelXOffset =
//        chartView.leftAxis.axisLineColor = .white
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        return chartView
    }()
    
    private var arrayValues = [ChartDataEntry]()
    private var dataSet = LineChartDataSet()
        
    public func setupChart(with_ arrayValues: [Double]){
        dataSet = LineChartDataSet(entries: makeArrayEntriesFromValues(from: arrayValues))
        dataSet.drawCirclesEnabled = true
        dataSet.drawValuesEnabled = false
        dataSet.circleColors = [.white]
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 3
        dataSet.colors = [UIColor.white]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = true
        dataSet.highlightColor = .white.withAlphaComponent(0.5)
        dataSet.highlightLineWidth = 1.5
        self.view.data = LineChartData(dataSet: dataSet)
        self.view.animate(xAxisDuration: 0)
        self.view.highlightValue(x: Double(arrayValues.count - 1), dataSetIndex: 0)
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
