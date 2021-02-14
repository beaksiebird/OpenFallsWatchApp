//
//  ReportMedicineInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//
import WatchKit
import Foundation
import CoreLocation

//Data points -> Meds Recording, Meds Location

class ReportMedicineInterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var isRequestingLocation = false
    var userLocation: CLLocation?
 
    
    @IBAction func recordMeds() {
       
        print("Recording Meds")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        manager.delegate = self
        requestLocation()
        
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

             self.isRequestingLocation = false

         }
        
     }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location delegate fail")
        
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
