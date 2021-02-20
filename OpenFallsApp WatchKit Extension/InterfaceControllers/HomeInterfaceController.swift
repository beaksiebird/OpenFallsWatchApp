//
//  HomeInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//


import WatchKit
import Foundation
import CoreLocation

//Data Points -> Fall yes/no, Fall Date
//-> Meds yes/no, Meds Date
//-> Study ID pulled from Admin user defaults

class HomeInterfaceController: WKInterfaceController, CLLocationManagerDelegate,URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate {
    
    var manager: CLLocationManager!
    var didFall = false
    var didMeds = false

  
    @IBAction func fallButton() {
        didFall = true
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringFall = df.string(from: date)
        print(dateStringFall)
        //Fall date/time
        //Fall location
        
        let controllers = "reportFallScreen"
        presentController(withName: controllers, context: nil)
        
    
    }
    @IBAction func medicineButton() {
        didMeds = true
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("birds")
        let dateStringMeds = df.string(from: date)
        print(dateStringMeds)
        //Meds Date/Time
        //Meds Location
        print("ths works")
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
    
    func pullStudyID() {
        //Stored StudyID
        if let savedID = UserDefaults.standard.object(forKey: "StudyID") {
            let storedStudyID = savedID
            print(storedStudyID)
        }
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

