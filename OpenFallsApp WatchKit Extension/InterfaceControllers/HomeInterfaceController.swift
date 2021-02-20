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
    var fallButtonPressedEvent = false
    var medsButtonPressedEvent = false

  
    @IBAction func fallButton() {
        fallButtonPressedEvent = true
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringFall = df.string(from: date)
        print(dateStringFall)
        //Fall date/time to device
        //Fall location to device
        //DidFall = True to device
        
        let controllers = "reportFallScreen"
        presentController(withName: controllers, context: nil)
        
    
    }
    @IBAction func medicineButton() {
        medsButtonPressedEvent = true
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringMeds = df.string(from: date)
        print(dateStringMeds)
        //Meds Date/Time to device
        //Meds Location to device
        //DidMeds = True to device
        Logger.log(dateStringMeds)
        
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

