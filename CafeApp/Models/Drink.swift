//
//  Drink.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//

import Foundation

enum DrinkType: String, CaseIterable{
    case coffee = "Coffee"
    case tea = "Tea"
    case chocolate = "Chocolate"
}

enum DrinkSize: String, CaseIterable{
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Drink{
    let type: DrinkType
    let size: DrinkSize
    let price: Double
    let extras: [String]
    let totalPrice: Double
}


