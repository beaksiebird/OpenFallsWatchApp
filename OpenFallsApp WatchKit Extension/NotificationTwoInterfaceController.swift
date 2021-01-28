//
//  NotificationTwoInterfaceController.swift
//  OpenFallsApp WatchKit Extension
//
//  Created by Whitney Bremer on 1/26/21.
//

import WatchKit
import Foundation


class NotificationTwoInterfaceController: WKInterfaceController {
    
    var timesFell = String()
    
    var itemList: [(String, String)] = [
           ("Falls", "1"),
           ("Falls", "2"),
           ("Falls", "3"),
           ("Falls", "4"),
           ("Falls", "5"),
           ("Falls", "6") ]

    @IBAction func uploadFall() {
        print("Uploading fall times from notification")
        print("\(timesFell)")
    }
    @IBOutlet weak var timesFellPicker: WKInterfacePicker!
    
    @IBAction func pickerDidChange(_ value: Int) {
        timesFell = itemList[value].1
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let pickerItems: [WKPickerItem] = itemList.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = $0.0
                pickerItem.title = $0.1
                return pickerItem
            }
            timesFellPicker.setItems(pickerItems)
    
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
