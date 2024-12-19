//
//  DrinkViewModel.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//
import SwiftUI
import Combine

class OrderViewModel: ObservableObject {
    @Published var selectedDrink: DrinkType = .coffee
    @Published var sliderValue: Double = 0.0 {
        didSet {
            selectedSize = sizeFromSliderValue(sliderValue)
        }
    }
    @Published var selectedSize: DrinkSize = .small
    @Published var addSugar: Bool = false
    @Published var addWhippedCream: Bool = false
    
    let availableCredit: Double = 4.70
    @Published private(set) var drinks: [Drink] = []

    private var cancellables = Set<AnyCancellable>()
    private let repository: any DrinkRepository

    init(repository: any DrinkRepository) {
        self.repository = repository
        
        // Observe repository changes
        if let repo = repository as? DrinkRepositoryDummyImpl {
            repo.$drinks
                .sink { [weak self] in
                    self?.drinks = $0
                }
                .store(in: &cancellables)
        } else {
            // If another repository implementation is used
            self.drinks = repository.drinks
        }
        
        self.drinks = repository.drinks
    }

    var currentDrink: Drink? {
        drinks.first(where: { $0.type == selectedDrink })
    }

    var totalPrice: Double {
        guard let d = currentDrink else { return 0.0 }
        let basePrice = d.prices[selectedSize] ?? 0.0
        var total = basePrice
        if addWhippedCream {
            total += ExtraPrices.whippedCream
        }
        // sugar is free, so no addition required
        return total
    }

    var canAddSugar: Bool {
        guard let d = currentDrink else { return false }
        return d.sugarAvailable
    }

    var isOverCredit: Bool {
        return totalPrice > availableCredit
    }

    var summaryText: String {
        var extrasDescription = ""
        if addSugar && canAddSugar {
            extrasDescription += " with sugar"
        }
        if addWhippedCream {
            if !extrasDescription.isEmpty {
                extrasDescription += " and whipped cream"
            } else {
                extrasDescription += " with whipped cream"
            }
        }

        let summary = "\(selectedSize.rawValue.lowercased()) \(selectedDrink.rawValue.lowercased())\(extrasDescription)"
        return summary
    }

    func sizeFromSliderValue(_ value: Double) -> DrinkSize {
        let rounded = Int(round(value))
        switch rounded {
        case 0: return .small
        case 1: return .medium
        default: return .large
        }
    }
}

