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
        initialDate()
        //uploadFilesToAWS()
    }

    func initialDate() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringLaunched = df.string(from: date)
        print(dateStringLaunched)
 //Save to device
    }
    
    func uploadFilesToAWS() {
        //Upload everything in device directory 
        
    }

    func pullStudyID() {
        //Stored StudyID
        if let savedID = UserDefaults.standard.object(forKey: "StudyID") {
            let storedStudyID = savedID
            print(storedStudyID)
            //Save to device 
        }
    }

    override func willActivate() {
     

    }

    
    override func didDeactivate() {
       
    }

 
}
