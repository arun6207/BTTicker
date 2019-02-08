//
//  BTTicker.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/6/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import Foundation
//    [ <id>, null, [ <currency pair id>, "<last trade price>", "<lowest ask>", "<highest bid>", "<percent change in last 24 hours>", "<base currency volume in last 24 hours>", "<quote currency volume in last 24 hours>", <is frozen>, "<highest trade price in last 24 hours>", "<lowest trade price in last 24 hours>" ], ... ]]
//    [149,"219.42870877","219.85995997","219.00000016","0.01830508","1617829.38863451","7334.31837942",0,"224.44803729","214.87902002"]]


class BTTicker: NSObject {
    @objc dynamic var currencyId: Int32
    var lastTradePrice: Double?
    var lowestAsk : Double?
    var highestBid: Double?
    var percentage: Double?
    var baseCurrencyVol: Double?
    var quoteCurrency: Double?
    var isFroZen: Bool?
    var highestTradePrice: Double?
    var lowestTradePrice: Double?
    var isUpdated: Bool = false
    
    init(marketDetails: [AnyObject]) {
        self.currencyId = marketDetails[0].int32Value
        self.lastTradePrice = marketDetails[1].doubleValue
        self.lowestAsk = marketDetails[2].doubleValue
        self.highestBid = marketDetails[3].doubleValue
        self.percentage = marketDetails[4].doubleValue
        self.baseCurrencyVol = marketDetails[5].doubleValue
        self.quoteCurrency = marketDetails[6].doubleValue
        self.isFroZen = marketDetails[7].boolValue
        self.highestTradePrice = marketDetails[8].doubleValue
        self.lowestTradePrice = marketDetails[9].doubleValue
    }
    func udpateTicckerData( newData: BTTicker) {
        self.lastTradePrice = newData.lastTradePrice
        self.lowestAsk = newData.lowestAsk
        self.highestBid = newData.highestBid
        self.percentage = newData.percentage
        self.baseCurrencyVol = newData.baseCurrencyVol
        self.quoteCurrency = newData.quoteCurrency
        self.isFroZen = newData.isFroZen
        self.highestTradePrice = newData.highestTradePrice
        self.lowestTradePrice = newData.lowestTradePrice
        self.isUpdated  = true
    }
   
    
}
