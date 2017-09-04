//
//  ViewController.swift
//  Cryptoticker
//
//  Created by Dani on 03/09/2017.
//  Copyright © 2017 Dani. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var updateBtn: NSButton!
  @IBOutlet weak var total: NSTextFieldCell!
  @IBOutlet weak var invested: NSTextFieldCell!
  @IBOutlet weak var btc: NSTextFieldCell!
  @IBOutlet weak var eth: NSTextFieldCell!
  @IBOutlet weak var balance: NSTextFieldCell!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  @IBAction func updateClicked(_ sender: Any) {

    let rates = Rates()
    rates.fetch(callback: self.refreshTotal)

  }

  func refreshTotal(rates: Rates) {
    DispatchQueue.main.async {
      let btc = Double(self.btc.title) ?? 0.0
      let eth = Double(self.eth.title) ?? 0.0

      let total = btc * (rates.eur["BTC"] ?? 0.0) + eth * (rates.eur["ETH"] ?? 0.0)
      self.total.title = String(format: "%.2f", total)

      let invested = Double(self.invested.title) ?? 0.0
      self.balance.title = "Delta: " + String(format: "%.2f", total - invested)
    }
  }
}

