//
//  HomeInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//


import WatchKit
import Foundation
import CoreLocation


class HomeInterfaceController: WKInterfaceController, CLLocationManagerDelegate,URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate {
    
    var manager: CLLocationManager!


  
    @IBAction func fallButton() {
        Event.create(eventType: Event.didFall, associatedFile: "", location: "")
        let controllers = "reportFallScreen"
        presentController(withName: controllers, context: nil)
        
    
    }
    @IBAction func medicineButton() {
        Event.create(eventType: Event.didMeds, associatedFile: "", location: "")
        let controllers = "reportMedicineScreen"
        presentController(withName: controllers, context: nil)

 
    }
    
    @IBOutlet weak var hoursSinceMeds: WKInterfaceLabel!
    @IBOutlet weak var fallsPerMonth: WKInterfaceLabel!
    @IBOutlet weak var fallsPerDay: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
   
    override func willActivate() {
        super.willActivate()
    
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    
    }
    


}

