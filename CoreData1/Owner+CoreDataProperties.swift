//
//  Owner+CoreDataProperties.swift
//  CoreData1
//
//  Created by Yash Vipul Naik on 2025-03-28.
//
//

import Foundation
import CoreData


extension Owner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: "Owner")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: UUID?
    @NSManaged public var yob: String?
    @NSManaged public var hasCars: NSSet?

}

// MARK: Generated accessors for hasCars
extension Owner {

    @objc(addHasCarsObject:)
    @NSManaged public func addToHasCars(_ value: Car)

    @objc(removeHasCarsObject:)
    @NSManaged public func removeFromHasCars(_ value: Car)

    @objc(addHasCars:)
    @NSManaged public func addToHasCars(_ values: NSSet)

    @objc(removeHasCars:)
    @NSManaged public func removeFromHasCars(_ values: NSSet)

}

extension Owner : Identifiable {

}
