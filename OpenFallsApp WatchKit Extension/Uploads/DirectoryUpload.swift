//
//  DirectoryUpload.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 2/12/21.
//

import Foundation


struct uploadPatientFile {
    static func uploadPatientData(fileName: URL, fileNameOnServer: String)  {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEE', 'dd' 'MMM' 'yyy' 'HH:mm:ss' 'Z"
        let dateForUploadFunc = df.string(from: date)
        print(dateForUploadFunc)
        let bucket = "openfallstesting"
        let myurl = "https://"+bucket+".s3.amazonaws.com/incoming/" + fileNameOnServer
     
        let configuration = URLSessionConfiguration.default
        let request = NSMutableURLRequest(url: NSURL(string: myurl)! as URL)
            request.httpMethod = "PUT"
        request.setValue(fileNameOnServer, forHTTPHeaderField: "fileNameOnServer")
        request.addValue(dateForUploadFunc, forHTTPHeaderField: "Date")
        let session = URLSession(configuration: configuration)
        let mData = session.uploadTask(with: request as URLRequest, fromFile: fileName) { (data, response, error) in
            if let res = response as? HTTPURLResponse {
                print("res: \(String(describing: res))")
                print("Response: \(String(describing: response))")
                
                if !FileManager.default.fileExists(atPath: Logger.logFile!.path) {
                    //Make sure file exists before trying to delete
                } else {
                    try! FileManager.default.removeItem(at: fileName)
                }
                
            } else {
                print("Error: \(String(describing: error))")
            }
        }
        mData.resume()
       }
}

class Event {
    static var recordedFall = "Recorded Fall"
    static var recordedMeds = "Recorded Meds"
    static var appStart = "App Launched"
    static var didFall = "Fall Button Pressed"
    static var didMeds = "Meds Button Pressed"
    static var callHelp = "Called For Help"
    static var recordingFailedFall = "Recording Failed"
    static var recordingNoPermissionFall = "User did not allow recording"
    static var recordingFailedMeds = "Recording Failed"
    static var recordingNoPermissionMeds = "User did not allow recording"

    static func create(eventType: String, associatedFile: String, location: String) {
        print("create : \(eventType)")
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let eventDate = df.string(from: date)
        
        //Stored StudyID
        var storedStudyID = "None Entered"
        if let savedID = UserDefaults.standard.string(forKey: "StudyID") {
            if storedStudyID != "" {
                storedStudyID = savedID
            }
            print("storedStudyID \(storedStudyID)")
        }
        let writtenData = "\(storedStudyID),\(eventType),\(location),\(eventDate),\(associatedFile)\n"
        Logger.log(writtenData)
    }
}

class Logger {

    static var logFile: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "databuffer.csv"
        return documentsDirectory.appendingPathComponent(fileName)
    }

    static func log(_ message: String) {
        print("inside actual logger : \(message)")
        guard let logFile = logFile else {
            print("something got horribly messed up \(message)")
            return
        }
        if !FileManager.default.fileExists(atPath: logFile.path) {
            print("LOG FILE NOT DETECTED.  CREATING NEW LOG FILE AND PUTTING HEADER IN")
            let data = "Study ID,Event Type,Event Location,Event Date/Time,Associated Files\n".data(using: String.Encoding.utf8)
            try! data!.write(to: logFile, options: .atomicWrite)
        }
        print("log file now exists, I will log this message \(message)")
        if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(message.data(using: String.Encoding.utf8)!)
                fileHandle.closeFile()
        } else {
            print("Failed to log event --> \(message)")
        }
    }
}

