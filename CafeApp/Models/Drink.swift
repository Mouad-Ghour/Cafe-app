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

struct DrinkPrices {
    static let coffeeSmall: Double = 2.10
    static let coffeeMedium: Double = 2.90
    static let coffeeLarge: Double = 3.20
    
    static let teaSmall: Double = 2.30
    static let teaMedium: Double = 3.10
    static let teaLarge: Double = 4.30
    
    static let chocolateSmall: Double = 2.50
    static let chocolateMedium: Double = 3.30
    static let chocolateLarge: Double = 5.10
    
    static let whippedCream: Double = 1.50
    static let Sugar: Double = 0.0
}

func priceForDrink(type: DrinkType, size: DrinkSize) -> Double{
    switch type {
    case .coffee:
        switch size{
        case .small: return DrinkPrices.coffeeSmall
        case .medium: return DrinkPrices.coffeeMedium
        case .large: return DrinkPrices.coffeeLarge
        }
    case .tea:
        switch size{
        case .small: return DrinkPrices.teaSmall
        case .medium: return DrinkPrices.teaMedium
        case .large: return DrinkPrices.teaLarge
        }
    case .chocolate:
        switch size{
        case .small: return DrinkPrices.chocolateSmall
        case .medium: return DrinkPrices.chocolateMedium
        case .large: return DrinkPrices.chocolateLarge
        }
    }
}

enum Extras: String {
    case sugar = "Sugar"
    case whippedCream = "Whipped Cream"
}


