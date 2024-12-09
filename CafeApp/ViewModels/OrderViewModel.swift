//
//  DrinkViewModel.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//

import SwiftUI


class OrderViewModel: ObservableObject{
    @Published var selectedDrink: DrinkType = .coffee
    @Published var selectedSize: DrinkSize = .small
    @Published var addSugar: Bool = false
    @Published var addWhippedCream: Bool = false
    
    let availableCredit: Double = 4.70
    
    var totalPrice: Double {
        var total = priceForDrink(type: selectedDrink, size: selectedSize)
        if addWhippedCream{
            total += DrinkPrices.whippedCream
        }
        //sugar is free so nothing to add here..
        return total
    }
    
    var canAddSugar: Bool {
        return selectedDrink != .chocolate
    }
    
    var isOverCredit: Bool {
        return totalPrice > availableCredit
    }
    
    var summaryText: String {
        
        var extrasDescription = ""
        if addSugar && canAddSugar{
            extrasDescription += " with sugar"
        }
        if addWhippedCream {
            if !extrasDescription.isEmpty{
                extrasDescription += " and whipped cream "
            }else{
                extrasDescription += " with whipped cream "
            }
        }
        
        let summary = "\(selectedSize.rawValue.lowercased()) \(selectedDrink.rawValue.lowercased()) \(extrasDescription)"
        return summary
    }
}
