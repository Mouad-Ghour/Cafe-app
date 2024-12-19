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

enum DrinkSize: String, CaseIterable, Hashable{
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Drink: Identifiable{
    let id = UUID()
    let type: DrinkType
    let prices: [DrinkSize: Double]
    let sugarAvailable: Bool
}

struct ExtraPrices{
    static let whippedCream: Double = 1.50
    static let sugar: Double = 0.0
}



