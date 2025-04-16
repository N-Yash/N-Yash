//
//  JobArray+CoreDataProperties.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-16.
//
//

import Foundation
import CoreData


extension JobArray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobArray> {
        return NSFetchRequest<JobArray>(entityName: "JobArray")
    }

    @NSManaged public var company: String?
    @NSManaged public var datePosted: String?
    @NSManaged public var employmentType: String?
    @NSManaged public var id: String?
    @NSManaged public var jobDescription: String?
    @NSManaged public var location: String?
    @NSManaged public var salaryRange: String?
    @NSManaged public var title: String?

}

extension JobArray : Identifiable {

}
