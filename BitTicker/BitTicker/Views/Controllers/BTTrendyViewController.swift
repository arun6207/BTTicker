//
//  BTMarket2ViewController.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/8/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit
import Charts

class BTTrendyViewController: UIViewController {

  // MARK: properties
    @IBOutlet weak var piePolyChart: PieChartView! //from iOS charts
    var tickerDataModel: BTTickerDataModel!
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PolyLine Chart"
        startTicker()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         tickerDataModel.getTickerDetails()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        tickerDataModel.stopTicker()
        configureChartView()
    }
    deinit {
        if let _ = tickerDataModel {
            tickerDataModel.stopTicker()
        }
    }
    func startTicker() {
        tickerDataModel =  BTTickerDataModel()
        tickerDataModel.delegate = self
    }
    func configureChartView() {
        piePolyChart.delegate = self
        
        piePolyChart.legend.enabled = false
        piePolyChart.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
        piePolyChart.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        self.updateChartData()
    }
    func updateChartData() {
        self.setDataCount(self.tickerDataModel.marketDetails.count, range: UInt32(self.tickerDataModel.marketDetails.count))
    }
    func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: String(self.tickerDataModel.marketDetails[i].currencyId))
        }
        
        let set = PieChartDataSet(values: entries, label: "Virtual currencies")
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        set.valueLinePart1OffsetPercentage = 0.8
        set.valueLinePart1Length = 0.2
        set.valueLinePart2Length = 0.4
        set.yValuePosition = .outsideSlice
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        piePolyChart.data = data
        piePolyChart.highlightValues(nil)
    }

}
extension BTTrendyViewController: BTTickerDataModelDelegate {
    func updatedMarketDetailsAtIndex(indexId: Int) {
        self.updateChartData()
    }
    func addedNewItemToTheMarket() {
        self.updateChartData()
    }
}
extension BTTrendyViewController: ChartViewDelegate {
    
}


