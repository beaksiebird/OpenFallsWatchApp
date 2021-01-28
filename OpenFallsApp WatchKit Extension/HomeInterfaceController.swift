//
//  HomeInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//


import WatchKit
import Foundation


class HomeInterfaceController: WKInterfaceController {
    
    var numberOfFalls = Int()
    @IBAction func fallButton() {
        print("Going to fall screen")
        numberOfFalls += 1
    }
    @IBAction func medicineButton() {
        print("Going to medicine screen")
    }
    
    @IBOutlet weak var hoursSinceMeds: WKInterfaceLabel!
    @IBOutlet weak var fallsPerMonth: WKInterfaceLabel!
    @IBOutlet weak var fallsPerDay: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
