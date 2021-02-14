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
