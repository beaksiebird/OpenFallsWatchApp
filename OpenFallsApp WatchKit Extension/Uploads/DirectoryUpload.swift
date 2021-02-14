//
//  DirectoryUpload.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 2/12/21.
//

import Foundation




class Logger {

    static var logFile: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "Fuzz.csv"
        return documentsDirectory.appendingPathComponent(fileName)
    }

    static func log(_ message: String) {
        print(message)
        guard let logFile = logFile else {
            return
        }
        guard let data = (message).data(using: String.Encoding.utf8) else { return }

        if FileManager.default.fileExists(atPath: logFile.path) {
            print("file exists")
            if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
                print(logFile.path)
            }
        } else {
            try? data.write(to: logFile, options: .atomicWrite)
        }
    }
}


//
//class UploadRequest {
//
//   static func uploadPatientData()  {
//    let date = Date()
//    let df = DateFormatter()
//    df.dateFormat = "EEE', 'dd' 'MMM' 'yyy' 'HH:mm:ss' 'Z"
//    //"yyyy-MM-dd HH:mm:ss"
//    let dateForUploadFunc = df.string(from: date)
//    print(dateForUploadFunc)
//
//        let fileName = String()
//        let bucket = "beakbeak1701"
//        let string = "http://"+bucket+".s3.amazonaws.com/incoming/" + fileName
//        let url = NSURL(string: string)
//        let request = NSMutableURLRequest(url: url! as URL)
//
//
//        request.httpMethod = "PUT"
//        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
//        request.addValue("*/*", forHTTPHeaderField: "Accept")
//        request.addValue(dateForUploadFunc, forHTTPHeaderField: "Date")
//
//        let session = URLSession.shared
//
//        let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//            if let res = response as? HTTPURLResponse {
//                print("res: \(String(describing: res))")
//                print("Response: \(String(describing: response))")
//            }else{
//                print("Error: \(String(describing: error))")
//            }
//        }
//        mData.resume()
//    }


