//
//  ViewController.swift
//  Cryptoticker
//
//  Created by Dani on 03/09/2017.
//  Copyright © 2017 Dani. All rights reserved.
//

import Cocoa
import CoreData

class ViewController: NSViewController {

  @IBOutlet weak var updateBtn: NSButton!
  @IBOutlet weak var invested: NSTextFieldCell!
  @IBOutlet weak var btc: NSTextFieldCell!
  @IBOutlet weak var eth: NSTextFieldCell!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.

    let appDelegate: AppDelegate = NSApplication.shared().delegate as! AppDelegate
    let moc = appDelegate.managedObjectContext

    // Initialize Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()

    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: "Balance", in: moc)

    // Configure Fetch Request
    fetchRequest.entity = entityDescription

    var result: [Any] = [] // yes, the results are Any, not NSManagedObject
    do {
      result = try moc.fetch(fetchRequest)

    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }

    //let person = result[0] as! NSManagedObject

    for balance in result {
      moc.delete(balance as! NSManagedObject)

      do {
        try moc.save()
      } catch {
        let saveError = error as NSError
        print(saveError)
      }
    }


    let balance = NSManagedObject(entity: entityDescription!, insertInto: moc)
    balance.setValue("BTC", forKey: "currency")
    balance.setValue(1.0, forKey: "amount")
    do {
      try balance.managedObjectContext?.save()
    } catch {
      print(error)
    }

    do {
      let result = try moc.fetch(fetchRequest)
      print(result)

    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
print("all done")

  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  @IBAction func updateClicked(_ sender: Any) {

    let btc = Double(self.btc.title) ?? 0.0
    let eth = Double(self.eth.title) ?? 0.0

  }
}

