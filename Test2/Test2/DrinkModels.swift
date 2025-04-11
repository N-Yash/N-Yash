//
//  File.swift
//  Test2
//
//  Created by Yash Vipul Naik on 2025-04-11.
//

import Foundation

class DrinkPreviewList: Codable {
    let drinks: [DrinkPreviewModel]
}

class DrinkPreviewModel: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String

    init(strDrink: String, strDrinkThumb: String, idDrink: String) {
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        self.idDrink = idDrink
    }
}

class DrinkDetailsList: Codable {
    let drinks: [DrinkDetailsModel]
}

class DrinkDetailsModel: Codable {
    let idDrink: String
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strInstructions: String?
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strDrinkThumb: String

    init(idDrink: String, strDrink: String, strCategory: String, strAlcoholic: String, strInstructions: String?, strInstructionsES: String?, strInstructionsDE: String?, strDrinkThumb: String) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strCategory = strCategory
        self.strAlcoholic = strAlcoholic
        self.strInstructions = strInstructions
        self.strInstructionsES = strInstructionsES
        self.strInstructionsDE = strInstructionsDE
        self.strDrinkThumb = strDrinkThumb
    }
}
