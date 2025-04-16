//
//  JobProviders+CoreDataProperties.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-16.
//
//

import Foundation
import CoreData


extension JobProviders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobProviders> {
        return NSFetchRequest<JobProviders>(entityName: "JobProviders")
    }

    @NSManaged public var jobProvider: String?
    @NSManaged public var url: String?
    @NSManaged public var jobId: SavedJob?

}

extension JobProviders : Identifiable {

}
