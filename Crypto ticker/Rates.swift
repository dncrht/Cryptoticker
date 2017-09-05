//
//  Rates.swift
//  Cryptoticker
//
//  Created by Dani on 04/09/2017.
//  Copyright © 2017 Dani. All rights reserved.
//

import Foundation

class Rates {
  var eur: [String: Double] = ["BTC": 0.0, "ETH": 0.0]

  func fetch(callback: @escaping (Rates) -> Void) {
    for currency in eur.keys {

      let url = URL(string: "https://cex.io/api/last_price/\(currency)/EUR")
      NSLog("Calling \(url!.absoluteString)")

      //NSLog(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)

      let task = URLSession.shared.dataTask(with: URLRequest(url: url!), completionHandler: { (data, response, error) in

        if error != nil {
          print(error!)
        } else {

          do {

            let json = try JSONSerialization.jsonObject(with: data!) as! [String: String]

            self.eur[currency] = Double(json["lprice"] ?? "0")

            NSLog("\(currency) = \(self.eur[currency])")

            callback(self)

          } catch let error as NSError {
            print(error)
          }
          
        }
      })
      
      task.resume()
      
      
    }
    
    return
  }
}
