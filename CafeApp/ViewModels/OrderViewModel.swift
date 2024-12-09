//
//  DrinkViewModel.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//

import SwiftUI


class DrinkViewModel: ObservableObject{
    @Published var selectedDrink: DrinkType = .coffee
    @Published var selectedSize: DrinkSize = .small
    @Published var extras: [String] = []
    @Published var total: Double = 0.0
    let credit: Double = 4.70
    
    private let prices: [DrinkType: [DrinkSize: Double]] = [
        .coffee: [.small: 2.10, .medium: 2.90, .large: 3.20],
        .tea: [.small: 2.30, .medium: 3.10, .large: 4.30],
        .chocolate: [.small: 2.50, .medium: 3.30, .large:5.10]
    ]
 
    func calculateTotal(){
        let drinkPrice = prices[selectedDrink]?[selectedSize] ?? 0
        let extrasPrice = extras.contains("Whipped Cream") ? 1.50 : 0.0
        total = drinkPrice + extrasPrice
    }
    
    var canPurchase: Bool {
        total <= credit
    }
    
}
