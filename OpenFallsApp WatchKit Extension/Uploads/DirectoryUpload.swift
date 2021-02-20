//
//  DirectoryUpload.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 2/12/21.
//

import Foundation


struct uploadPatientFile {
    
    static func uploadPatientData(fileName: URL)  {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEE', 'dd' 'MMM' 'yyy' 'HH:mm:ss' 'Z"
        //"yyyy-MM-dd HH:mm:ss"
        let dateForUploadFunc = df.string(from: date)
        print(dateForUploadFunc)

        let bucket = "beakbeak1701"
        let string = "https://"+bucket+".s3.amazonaws.com/incoming/" + fileName.lastPathComponent
        print("HERE IS URL IN UPLOADPATIENTDATA")
        print(string)
            let url = NSURL(string: string)
            let request = NSMutableURLRequest(url: url! as URL)


            request.httpMethod = "PUT"
            request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
            request.addValue("*/*", forHTTPHeaderField: "Accept")
            request.addValue(dateForUploadFunc, forHTTPHeaderField: "Date")

            let session = URLSession.shared

        //need upload task
        let mData = session.uploadTask(with: request as URLRequest, fromFile: url! as URL) { (data, response, error) in
            
            if let res = response as? HTTPURLResponse {
                print("res: \(String(describing: res))")
                print("Response: \(String(describing: response))")
            } else {
                print("Error: \(String(describing: error))")
            }
        }
//
//            let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//                if let res = response as? HTTPURLResponse {
//                    print("res: \(String(describing: res))")
//                    print("Response: \(String(describing: response))")
//                } else {
//                    print("Error: \(String(describing: error))")
//                }
//            }
            mData.resume()
        
       }
}

class Logger {

    static var logFile: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
  
        let fileName = "Birdsarefuzzy2.csv"
        return documentsDirectory.appendingPathComponent(fileName)
    }

    static func log(_ message: String) {
        print("Fur")
        guard let logFile = logFile else {
            return
        }

        guard let data = "Study ID, Initial Date/Time, Event Type, Event Location, Event Date/Time, Associated Files\n\n".data(using: String.Encoding.utf8) else { return }

        if FileManager.default.fileExists(atPath: logFile.path) {
            if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                print(logFile)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        } else {
            print(logFile)
            try? data.write(to: logFile, options: .atomicWrite)
        }
    }
}


//class Logger {
//
//    static var logFile: URL? {
//        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        let fileName = "beakbeak.csv"
//        return documentsDirectory.appendingPathComponent(fileName)
//    }
//
//    static func log(_ message: String) {
//        print(message)
//        guard let logFile = logFile else {
//            return
//        }
//        guard let data = (message).data(using: String.Encoding.utf8) else { return }
//        let fileExists = FileManager.default.fileExists(atPath: logFile.path)
//
//        if let fileHandle = try? FileHandle(forWritingTo: logFile) {
//
//            if !fileExists {
//                print("File doesnt exist")
//
//                Logger.log("Study ID, Initial Date/Time, Event Type, Event Location, Event Date/Time,  Associated Files")
//            } else {
//                print("File exists")
//                fileHandle.seekToEndOfFile()
//            }
//            print("Fir")
//
//            fileHandle.write(data)
//            fileHandle.closeFile()
//            print(logFile.path)
//        } else {
//            print("birdfur")
//        }
//    }
//}

