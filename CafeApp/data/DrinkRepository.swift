//
//  DrinkRepository.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 19/12/2024.
//

import Foundation
import Combine

protocol DrinkRepository: ObservableObject {
    var drinks: [Drink] { get }
}

class DrinkRepositoryDummyImpl: DrinkRepository {
    @Published var drinks: [Drink] = [
        Drink(type: .coffee,
              prices: [.small: 2.10, .medium: 2.90, .large: 3.20],
              sugarAvailable: true),
        Drink(type: .tea,
              prices: [.small: 2.30, .medium: 3.10, .large: 4.30],
              sugarAvailable: true),
        Drink(type: .chocolate,
              prices: [.small: 2.50, .medium: 3.30, .large: 5.10],
              sugarAvailable: false)
    ]

    var objectWillChange = PassthroughSubject<Void, Never>()
    var publishedDrinks: Published<[Drink]> { _drinks }
    var publishedDrinksPublisher: Published<[Drink]>.Publisher { $drinks }

    init() {}
}

