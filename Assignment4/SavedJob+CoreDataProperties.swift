//
//  SavedJob+CoreDataProperties.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-16.
//
//

import Foundation
import CoreData


extension SavedJob {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedJob> {
        return NSFetchRequest<SavedJob>(entityName: "SavedJob")
    }

    @NSManaged public var company: String?
    @NSManaged public var datePosted: String?
    @NSManaged public var jobDescrption: String?
    @NSManaged public var employmrntType: String?
    @NSManaged public var id: String?
    @NSManaged public var location: String?
    @NSManaged public var salaryRange: String?
    @NSManaged public var title: String?
    @NSManaged public var jobProvider: NSSet?

}

// MARK: Generated accessors for jobProvider
extension SavedJob {

    @objc(addJobProviderObject:)
    @NSManaged public func addToJobProvider(_ value: JobProviders)

    @objc(removeJobProviderObject:)
    @NSManaged public func removeFromJobProvider(_ value: JobProviders)

    @objc(addJobProvider:)
    @NSManaged public func addToJobProvider(_ values: NSSet)

    @objc(removeJobProvider:)
    @NSManaged public func removeFromJobProvider(_ values: NSSet)

}

extension SavedJob : Identifiable {

}
