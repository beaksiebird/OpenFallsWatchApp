//
//  ViewController.swift
//  OpenFallsApp
//
//  Created by Whitney Bremer on 1/26/21.
//

import UIKit
import WatchConnectivity
import Network

class ViewController: UIViewController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            sendWatchMessage()
        }

    
    }
    
    func sendWatchMessage() {
        let monitor = NWPathMonitor()
        
                monitor.pathUpdateHandler = { path in
                    if path.status != .satisfied {
                        print("No connectivity")
                    } else {
                        print("Watch is connected to wifi or cellular")
                    }
        
                }
        
                let queue = DispatchQueue(label: "Monitor")
                monitor.start(queue: queue)
    }
 
}

