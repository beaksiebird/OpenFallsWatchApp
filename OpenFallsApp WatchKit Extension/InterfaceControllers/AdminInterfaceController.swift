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
        print(studyTextValue)
        let defaults = UserDefaults.standard
        defaults.set(studyTextValue, forKey: "StudyID")
        defaults.synchronize()
        
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
    }

}
