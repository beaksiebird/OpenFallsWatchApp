//
//  NotificationController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationController: WKUserNotificationInterfaceController {


    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
      
    
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        
    }

    override func didReceive(_ notification: UNNotification) {
     
    }
}
