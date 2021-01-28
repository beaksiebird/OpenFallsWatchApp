//
//  ReportFallInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//

import WatchKit
import Foundation
//import AVFoundation

class ReportFallInterfaceController: WKInterfaceController {
                                     
                                     //AVAudioRecorderDelegate {

//    var recordingSession: AVAudioSession!
//    var fallRecorder: AVAudioRecorder!

    
//    @IBAction func recordFall() {
//        //Request permission for microphone use
//        print("Recording Fall")
//        recordingSession = AVAudioSession.sharedInstance()
//
//        do {
//               try recordingSession.setCategory(.playAndRecord, mode: .default)
//               try recordingSession.setActive(true)
//               recordingSession.requestRecordPermission() { [unowned self] allowed in
//                   DispatchQueue.main.async {
//                       if allowed {
//                           print("Permission granted.")
//                        self.startRecording()
//                       } else {
//                           print("Permission not granted")
//                       }
//                   }
//               }
//           } catch {
//              print("Recording functionality not working")
//           }
//
//    }
    
//    func startRecording() {
//        //Actual recording
//        let audioURL = ReportFallInterfaceController.getRecordingURL()
//        print("Here is fall recording URL")
//        print(audioURL.absoluteString)
//        let settings = [
//              AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//              AVSampleRateKey: 12000,
//              AVNumberOfChannelsKey: 1,
//              AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//          ]
//
//        do {
//               // 5
//               fallRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
//               fallRecorder.delegate = self
//               fallRecorder.record()
//           } catch {
//               finishRecording(success: false)
//           }
//    }
//
//    func finishRecording(success: Bool) {
//        fallRecorder.stop()
//        fallRecorder = nil
//
//    }
//
//    @objc func nextTapped() {
//
//    }
//
//    @objc func recordTapped() {
//        if fallRecorder == nil {
//            startRecording()
//        } else {
//            finishRecording(success: true)
//        }
//    }
//
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            print("Probelem with finished recording")
//            finishRecording(success: false)
//        }
//    }
//
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getRecordingURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("recordedfall.m4a")
    }
    
    @IBAction func callHelp() {
        print("Calling emergency services")
        let phone = "4047317508"
        if let telURL = URL(string: "tel:\(phone)") {
            let wkExt = WKExtension.shared()
            wkExt.openSystemURL(telURL)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
      
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
