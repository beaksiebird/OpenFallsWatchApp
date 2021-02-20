//
//  ReportMedicineInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//
import WatchKit
import Foundation
import CoreLocation
import AVFoundation


class ReportMedicineInterfaceController: WKInterfaceController, CLLocationManagerDelegate, AVAudioRecorderDelegate {
    
    let manager = CLLocationManager()
    var isRequestingLocation = false
    var userLocation: CLLocation?
    var recordingSession: AVAudioSession!
    var fallRecorder: AVAudioRecorder!
    var audioURL = getRecordingURL()
    var recordMedsEvent = false
  
 
    @IBAction func recordMeds() {
       recordMedsEvent = true 
        //Save to device 
        print("Recording Meds")
        requestLocation()
        print("Recording Fall")
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
                            
                            uploadPatientFile.uploadPatientData(fileName: audioURL)
             
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
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        manager.delegate = self
        
    }
    
  
    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
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
            //Save location to device

             self.isRequestingLocation = false

         }
        
     }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location delegate fail")
        
    }
    
}
