//
//  AdminInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//


import WatchKit
import Foundation


class AdminInterfaceController: WKInterfaceController {
    
    var fileManager: FileManager?
    var studyTextValue = NSString()
    @IBOutlet weak var studyIDText: WKInterfaceTextField!
    
    @IBAction func enterStudyID(_ value: NSString?) {
        studyIDText.setText(value as String?)
        studyTextValue = value ?? ""
    
    }
    @IBAction func uploadData() {
        print("Uploading patient data")
   
        let uuid = UUID().uuidString
        uploadPatientFile.uploadPatientData(fileName: Logger.logFile! ,fileNameOnServer: "\(uuid).csv")
        self.dismiss()
      
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
      
    }

    override func willActivate() {
        studyIDText.setText("")
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
        print(studyTextValue)
        let defaults = UserDefaults.standard
        defaults.set(studyTextValue, forKey: "StudyID")
        defaults.synchronize()
    }

}
