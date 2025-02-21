//
//  model.swift
//  Assignment
//
//  Created by Yash Vipul Naik on 2025-02-21.
//

import Foundation

class Product{
    var productName : String?
    var productQuantity : Int?
    var productPrice : Int?
    
    init(productName: String?, productQuantity: Int?, productPrice: Int?) {
        self.productName = productName
        self.productQuantity = productQuantity
        self.productPrice = productPrice
    }
}
