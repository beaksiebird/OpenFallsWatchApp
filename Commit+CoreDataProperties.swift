//
//  Commit+CoreDataProperties.swift
//  OpenFallsApp
//
//  Created by Whitney Bremer on 3/13/21.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var timesFell: Int16
    @NSManaged public var timeSinceLastFall: String
    @NSManaged public var timeSinceLastMeds: String

}

extension Commit : Identifiable {

}
