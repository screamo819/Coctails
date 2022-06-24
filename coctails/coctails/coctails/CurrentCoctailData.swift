//
//  CurrentCoctailData.swift
//  coctails
//
//  Created by AnnaEvgen on 07.06.2022.
//

import Foundation

struct Coctails: Codable {
    var drinks: [Drink]?
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
