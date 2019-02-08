//
//  ViewController.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/6/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit
import Starscream

class BTTickerViewController: UIViewController {
    // MARK: properties
    @IBOutlet weak var marketNavigationBar: UINavigationBar!
    var tickerDataModel: BTTickerDataModel!
    @IBOutlet weak var marketTableView: UITableView!
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Market"
        self.marketTableView.dataSource = self
        startTicker()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tickerDataModel.getTickerDetails()
        self.marketTableView.reloadData()
        
    }
    func startTicker() {
        tickerDataModel =  BTTickerDataModel()
        tickerDataModel.delegate = self
        
    }
    
    @IBAction func logoutButtonClick(_ sender: Any) {
         BTNetworkServices.sharedInstance().logout()
          self.view.window?.rootViewController?.dismiss(animated: true, completion: nil) 
    }
}
// MARK: UITableView DataSource methods
extension BTTickerViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickerDataModel.marketDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.configureTableViewCell(tableView, cellForRowAt: indexPath)
    }
    func configureTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BTMarketTableViewCell") as? BTMarketTableViewCell
        let tickerDetails = tickerDataModel.marketDetails[indexPath.row]
        cell?.middleLabel.text = String(tickerDetails.lastTradePrice!)
        cell?.rightLabel.text = String(tickerDetails.percentage!)
        cell?.leftLabel.text = String(tickerDetails.currencyId)
        if tickerDetails.isUpdated {
            (tickerDetails.percentage! > 0.00) ? (cell?.contentView.backgroundColor = .green) : (cell?.contentView.backgroundColor = .red)
            UIView.animate(withDuration: 0.4, animations: {
                cell?.contentView.backgroundColor = .clear
            })
        }
        return cell!
    }
}
// MARK: Ticker Delegate methods
extension BTTickerViewController: BTTickerDataModelDelegate {
    func updatedMarketDetailsAtIndex(indexId: Int) {
        self.marketTableView.reloadRows(at: [IndexPath(row: indexId, section: 0)], with: .automatic)
    }
    func addedNewItemToTheMarket() {
            let indexPath = IndexPath(row: tickerDataModel.marketDetails.count - 1 , section: 0)
            self.marketTableView.insertRows(at: [indexPath], with: .bottom)
    }
}

