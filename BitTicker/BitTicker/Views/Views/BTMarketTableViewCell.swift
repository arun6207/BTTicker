//
//  BTMarketTableViewCell.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/6/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit

class BTMarketTableViewCell: UITableViewCell {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    private var observerContext = 0
//    var object: BTTicker? {
//        willSet {
//            object?.removeObserver(self, forKeyPath: #keyPath(BTTicker.currencyId), context: &observerContext)
//        }
//        didSet {
//            object?.addObserver(self, forKeyPath: #keyPath(BTTicker.currencyId), context: &observerContext)
//        }
//    }
//
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        guard context == &observerContext else {
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//            return
//        }
//    }
    
//    deinit {
//        object?.removeObserver(self, forKeyPath: #keyPath(BTTicker.currencyId), context: &observerContext)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
