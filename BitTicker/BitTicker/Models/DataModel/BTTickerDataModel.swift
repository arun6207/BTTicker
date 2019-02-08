//
//  BTTickerViewModel.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/8/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit
protocol BTTickerDataModelDelegate: class {
    func updatedMarketDetailsAtIndex(indexId: Int)
    func addedNewItemToTheMarket()
}
class BTTickerDataModel: NSObject {
    var marketDetails: [BTTicker] = [BTTicker]()
    weak var delegate: BTTickerDataModelDelegate!
    func getTickerDetails() {
        BTNetworkServices.sharedInstance().getTickerUpdates(channelId: .ticker)
        BTNetworkServices.sharedInstance().delegate = self
    }
    func stopTicker(){
        BTNetworkServices.sharedInstance().socket.disconnect()
    }
    deinit {
       stopTicker()
    }
}
extension BTTickerDataModel:  BTNetworkServicesDelegate {
    func updateMarketValues(newData: BTTicker) {
        if let index = self.marketDetails.index(where: {$0.currencyId == newData.currencyId}) {
            self.marketDetails[index].udpateTicckerData(newData: newData)
            delegate?.updatedMarketDetailsAtIndex(indexId: index)
        }
        else {
            self.marketDetails.append(newData)
            delegate?.addedNewItemToTheMarket()
        }
    }
}
