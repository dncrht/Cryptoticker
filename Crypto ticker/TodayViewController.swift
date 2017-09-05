//
//  TodayViewController.swift
//  Crypto ticker
//
//  Created by Dani on 05/09/2017.
//  Copyright © 2017 Dani. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

  @IBOutlet weak var total: NSTextFieldCell!
  @IBOutlet weak var balance: NSTextFieldCell!

  override var nibName: String? {
      return "TodayViewController"
  }

  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you

    let rates = Rates()
    rates.fetch(callback: self.refreshTotal)

    completionHandler(.noData)
  }

  func refreshTotal(rates: Rates) {
    DispatchQueue.main.async {
      let btc = 0.33706295
      let eth = 2.011987

      let total = btc * (rates.eur["BTC"] ?? 0.0) + eth * (rates.eur["ETH"] ?? 0.0)
      self.total.title = String(format: "%.2f", total)

      let invested = 2246.15
      self.balance.title = "Delta: " + String(format: "%.2f", total - invested)
    }
  }

}
