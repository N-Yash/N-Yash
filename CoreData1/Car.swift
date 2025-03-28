//
//  Car.swift
//  CoreData1
//
//  Created by Yash Vipul Naik on 2025-03-28.
//
//

import Foundation
import SwiftData


@Model public class Car {
    var car_id: UUID?
    var model: String?
    var year: Int64? = 0
    var ownerBy: Owner?
    public init() {

    }
    
}
