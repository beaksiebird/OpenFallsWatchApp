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



class ReportFallInterfaceController: WKInterfaceController, AVAudioRecorderDelegate, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var isRequestingLocation = false
    var userLocation: CLLocation?
    var recordingSession: AVAudioSession!
    var fallRecorder: AVAudioRecorder!
    let monitor = NWPathMonitor()
    var calledHelpEvent = false
    var audioURL = getRecordingURL()
    var recordFallEvent = false
    var locationString = String()

    
    @IBOutlet weak var fallButtonOutlet: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        manager.delegate = self
        requestLocation()
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
            
            let lat = lastLocationCoordinate.latitude
            let long = lastLocationCoordinate.longitude
            
            self.locationString = "\(lat) \(long)"
            
            self.isRequestingLocation = false

         }
        
     }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location delegate fail")
        
    }
    

    @IBAction func recordFall() {

        //Request permission for microphone use
              recordingSession = AVAudioSession.sharedInstance()
      
        do {
            try recordingSession.setCategory(.record, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        if fallRecorder == nil {
                            self.startRecording()
                        } else {
                            self.fallRecorder.stop()
                            fallRecorder = nil
                            Event.create(eventType: Event.recordedFall, associatedFile: "INSERT FILE HERE", location: locationString)
                            //Upload recording to AWS
                          // uploadPatientFile.uploadPatientData(fileName: audioURL)
                           
                           
                        }
                        
                    } else {
                        print("Permission not granted")
                        Event.create(eventType: Event.recordingNoPermissionFall, associatedFile: "N/A", location: locationString)
                    }
                }
            }
        } catch {
            print("Recording functionality not working")
            Event.create(eventType: Event.recordingFailedFall, associatedFile: "N/A", location: locationString)
        }


    }
    
    
    func startRecording() {
            //Actual recording
            let fallAudioURL = audioURL
            print("Here is fall recording URL")
            print(fallAudioURL.absoluteString)
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
                Event.create(eventType: Event.recordingFailedFall, associatedFile: "N/A", location: locationString)
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
         return getDocumentsDirectory().appendingPathComponent("fallrecording.m4a")
     }
    
  
    @IBAction func callHelp() {
        Event.create(eventType: Event.callHelp, associatedFile: "N/A", location: locationString)

        print("Calling emergency services")
        let phone = ""
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
        
        
    }
    
   
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
