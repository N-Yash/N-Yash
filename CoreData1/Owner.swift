//
//  Owner.swift
//  CoreData1
//
//  Created by Yash Vipul Naik on 2025-03-28.
//
//

import Foundation
import SwiftData


@Model public class Owner {
    var id: UUID?
    var name: UUID?
    var yob: String?
    var hasCars: [Car]?
    public init() {

    }
    
}
