//
//  HomeInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//


import WatchKit
import Foundation
import CoreLocation
import CoreData
import UserNotifications



class HomeInterfaceController: WKInterfaceController, CLLocationManagerDelegate,URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate {
 
    var manager: CLLocationManager!
    var medItems = [Commit]()
    var moc: NSManagedObjectContext!
    let context = WKExtension.shared().delegate as! ExtensionDelegate


    @IBAction func fallButton() {
        Event.create(eventType: Event.didFall, associatedFile: "N/A", location: "N/A")
        let controllers = "reportFallScreen"
        presentController(withName: controllers, context: nil)
        
    
    }
    @IBAction func medicineButton() {
        Event.create(eventType: Event.didMeds, associatedFile: "N/A", location: "N/A")
        let controllers = "reportMedicineScreen"
        presentController(withName: controllers, context: nil)

 
    }
    
    @IBOutlet weak var hoursSinceMeds: WKInterfaceLabel!
    @IBOutlet weak var fallsPerMonth: WKInterfaceLabel!
    @IBOutlet weak var fallsPerDay: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
    }
    
    func loadData() {
        print("load data")

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Commit")
                
                request.returnsObjectsAsFaults = false
                do {
                    moc = context.persistentContainer.viewContext
                    let result = try moc.fetch(request)
                    for data in result as! [NSManagedObject] {
                        //Update label 
                        hoursSinceMeds.setText((data.value(forKey: "timeSinceLastMeds") as! String))
                  }
                    
                } catch {
                    
                    print("Failed")
                }
    }

   
    override func willActivate() {
        super.willActivate()
            loadData()
    }
    
    
    override func didDeactivate() {
        super.didDeactivate()
        
  
    
    }
    
  
  
}

