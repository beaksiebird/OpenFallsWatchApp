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
   
        Logger.log(dateStringFall)
        

    
    }
    @IBAction func medicineButton() {
        didMeds = true
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringMeds = df.string(from: date)
        print(dateStringMeds)
        //Meds Date/Time
        //Meds Location
        Logger.log(dateStringMeds)
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
        uploadPatientData()
        
        Logger.log("Study ID, Initial Date/Time, Event Type, Event Location, Event Date/Time,  Associated Files")
        
    }
    
   

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    


    func uploadPatientData()  {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEE', 'dd' 'MMM' 'yyy' 'HH:mm:ss' 'Z"
        //"yyyy-MM-dd HH:mm:ss"
        let dateForUploadFunc = df.string(from: date)
        print(dateForUploadFunc)

            let fileName = "doesthiswork2.txt"
            let bucket = "beakbeak1701"
            let string = "https://"+bucket+".s3.amazonaws.com/incoming/" + fileName
            let url = NSURL(string: string)
            let request = NSMutableURLRequest(url: url! as URL)


            request.httpMethod = "PUT"
            request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
            request.addValue("*/*", forHTTPHeaderField: "Accept")
            request.addValue(dateForUploadFunc, forHTTPHeaderField: "Date")

            let session = URLSession.shared

            let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                if let res = response as? HTTPURLResponse {
                    print("res: \(String(describing: res))")
                    print("Response: \(String(describing: response))")
                }else{
                    print("Error: \(String(describing: error))")
                }
            }
            mData.resume()
        
       }
}

