//
//  Injector.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 19/12/2024.
//

import Foundation

class Injector {
    static let drinkRepository: any DrinkRepository = DrinkRepositoryDummyImpl()
}
