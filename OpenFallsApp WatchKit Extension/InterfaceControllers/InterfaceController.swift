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

class InterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {

    @IBAction func toPatientScreen() {
        let controllers = "homeScreen"
        presentController(withName: controllers, context: nil)
    }
    
 
    @IBAction func toAdminScreen() {
        let controllers = "adminScreen"
        presentController(withName: controllers, context: nil)
    }
    

 
    override func awake(withContext context: Any?) {
     

    }


    override func willActivate() {
   //Upload to AWS for now
        let uuid = UUID().uuidString
        uploadPatientFile.uploadPatientData(fileName: Logger.logFile! ,fileNameOnServer: "\(uuid).csv")

    }

    
    override func didDeactivate() {
       
    }

 
}
