//
//  ReportFallInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//

import WatchKit
import Foundation
import AVFoundation
import Network
import CoreLocation

//Data Points -> Fall recording, Fall location, Call help yes/no, Call help time


class ReportFallInterfaceController: WKInterfaceController, AVAudioRecorderDelegate, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var isRequestingLocation = false
    var userLocation: CLLocation?
    var recordingSession: AVAudioSession!
    var fallRecorder: AVAudioRecorder!
    let monitor = NWPathMonitor()
    var calledHelp = false
    
    @IBOutlet weak var fallButtonOutlet: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        manager.delegate = self
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Watch is connected to wifi or cellular")
            } else {
                print("No connectivity")
                self.callForHelpLabel.setText("No WIFI or cellular connection")
                self.callHelpButton.setEnabled(false)
                self.callHelpButton.setAlpha(0.5)
            }
            
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func requestLocation() {

         guard !isRequestingLocation else {
             manager.stopUpdatingLocation()
             isRequestingLocation = false
             return
         }

        let authorizationStatus = manager.authorizationStatus

         switch authorizationStatus {
         case .notDetermined:
             isRequestingLocation = true
             manager.requestWhenInUseAuthorization()

         case .authorizedWhenInUse:
             isRequestingLocation = true
             manager.requestLocation()

         case .denied:
             print("Location Authorization Denied")
         default:
             print("Location AUthorization Status Unknown")
         }
     }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard !locations.isEmpty else { return }

         DispatchQueue.main.async {
             let lastLocationCoordinate = locations.last!.coordinate

             print("Lat =  \(lastLocationCoordinate.latitude)")

             print("Long = \(lastLocationCoordinate.longitude)")

             self.isRequestingLocation = false

         }
        
     }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location delegate fail")
        
    }
    

    @IBAction func recordFall() {
        
        //Request permission for microphone use
        requestLocation()
        print("Recording Fall")
        //Request permission for microphone use
              print("Recording Fall")
              recordingSession = AVAudioSession.sharedInstance()
      
        do {
            try recordingSession.setCategory(.record, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Permission granted.")
                    
                        if fallRecorder == nil {
                            self.startRecording()
                        } else {
                            self.fallRecorder.stop()
                            fallRecorder = nil
                        }
                        
                    } else {
                        print("Permission not granted")
                    }
                }
            }
        } catch {
            print("Recording functionality not working")
        }


    }
    
    
    func startRecording() {
            //Actual recording
            let audioURL = ReportFallInterfaceController.getRecordingURL()
            print("Here is fall recording URL")
            print(audioURL.absoluteString)
            let settings = [
                  AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                  AVSampleRateKey: 12000,
                  AVNumberOfChannelsKey: 1,
                  AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
              ]
    
            do {
                   fallRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
                   fallRecorder.delegate = self
                   fallRecorder.record()
               } catch {
                fallRecorder.stop()
                fallRecorder = nil
               }
        }
    
   

    class func getDocumentsDirectory() -> URL {
         let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         let documentsDirectory = paths[0]
         return documentsDirectory
     }

     class func getRecordingURL() -> URL {
         return getDocumentsDirectory().appendingPathComponent("bird.m4a")
     }
    
  
    @IBAction func callHelp() {
        calledHelp = true
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStringCallHelp = df.string(from: date)
        print(dateStringCallHelp)
        
        print("Calling emergency services")
        let phone = "4047317508"
        if let telURL = URL(string: "tel:\(phone)") {
            let wkExt = WKExtension.shared()
            wkExt.openSystemURL(telURL)
        }
    }
    
    @IBOutlet weak var callForHelpLabel: WKInterfaceLabel!
    
    @IBOutlet weak var callHelpButton: WKInterfaceButton!
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        fallRecorder.stop()
        fallRecorder = nil
    }
    
    
        private func documentDirectory() -> String {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                        .userDomainMask,
                                                                        true)
            return documentDirectory[0]
        }
    
        private func append(toPath path: String,
                            withPathComponent pathComponent: String) -> String? {
            if var pathURL = URL(string: path) {
                pathURL.appendPathComponent(pathComponent)
    
                return pathURL.absoluteString
            }
    
            return nil
        }
    
        private func save(text: String,
                          toDirectory directory: String,
                          withFileName fileName: String) {
            guard let filePath = self.append(toPath: directory,
                                             withPathComponent: fileName) else {
                return
            }
    
            do {
                try text.write(toFile: filePath,
                               atomically: true,
                               encoding: .utf8)
                print(filePath)
            } catch {
                print("Error", error)
                return
            }
    
            print("Save successful")
        }
  

}
