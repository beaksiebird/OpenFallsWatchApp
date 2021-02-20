//
//  InterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//

import WatchKit
import Foundation
import UserNotifications
import CoreLocation



//Data Points -> Date/Time Launched App


class InterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {


    @IBOutlet weak var adminButton: WKInterfaceButton!
    
    @IBOutlet weak var patientButton: WKInterfaceButton!
    
    @IBAction func toPatientScreen() {
        let controllers = "homeScreen"
        presentController(withName: controllers, context: nil)
    }
    
 
    @IBAction func toAdminScreen() {
        let controllers = "adminScreen"
        presentController(withName: controllers, context: nil)
    }
    

 
    override func awake(withContext context: Any?) {
        initialDate()
    
        uploadFilesToAWS()
    }

    func initialDate() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringLaunched = df.string(from: date)
        print(dateStringLaunched)
        
        //Save this to documents directory
    }
    
    func uploadFilesToAWS() {
        //Upload everything in device directory 
        
    }

    
    override func willActivate() {
     

    }

    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

 
}
