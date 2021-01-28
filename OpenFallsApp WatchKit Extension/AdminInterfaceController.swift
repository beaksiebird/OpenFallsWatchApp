//
//  AdminInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//


import WatchKit
import Foundation


class AdminInterfaceController: WKInterfaceController {
    
    var studyTextValue = NSString()
    @IBOutlet weak var studyIDText: WKInterfaceTextField!
    
    @IBAction func enterStudyID(_ value: NSString?) {
        studyIDText.setText(value as String?)
        studyTextValue = value ?? ""
    
    }
    @IBAction func uploadData() {
        //Upload studyTextValue
        print("Uploading patient data")
        print(studyTextValue)
        //When upload successful, clear studyTextValue
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        studyIDText.setText("")
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
