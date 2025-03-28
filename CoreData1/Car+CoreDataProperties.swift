//
//  Car+CoreDataProperties.swift
//  CoreData1
//
//  Created by Yash Vipul Naik on 2025-03-28.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var car_id: UUID?
    @NSManaged public var model: String?
    @NSManaged public var year: Int64
    @NSManaged public var ownerBy: Owner?

}

extension Car : Identifiable {

}
