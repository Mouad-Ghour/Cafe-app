//
//  ChooseDrink.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//
import SwiftUI

struct OrderSelectionView: View {
    @StateObject var viewModel = OrderViewModel(repository: Injector.drinkRepository)
    @State private var showingSummary = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Drink")) {
                    Picker("Drink", selection: $viewModel.selectedDrink) {
                        ForEach(viewModel.drinks, id: \.id) { drink in
                            HStack {
                                Text(drink.type.rawValue)
                                Spacer()
                                if let price = drink.prices[viewModel.selectedSize] {
                                    Text("€ \(String(format: "%.2f", price))")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .tag(drink.type)
                        }
                    }
                    .pickerStyle(.inline)
                }

                Section(header: Text("Size")) {
                    VStack {
                        Slider(
                            value: $viewModel.sliderValue,
                            in: 0...2,
                            step: 1
                        )
                        .accessibilityLabel("Size Slider")

                        HStack {
                            Text("Small").font(.caption)
                            Spacer()
                            Text("Medium").font(.caption)
                            Spacer()
                            Text("Large").font(.caption)
                        }
                    }
                }

                Section(header: Text("Extras")) {
                    Toggle(isOn: $viewModel.addSugar) {
                        HStack {
                            Text("Sugar")
                            Spacer()
                            Text("Free")
                                .foregroundColor(.secondary)
                        }
                    }
                    .disabled(!viewModel.canAddSugar)

                    Toggle(isOn: $viewModel.addWhippedCream) {
                        HStack {
                            Text("Whipped cream")
                            Spacer()
                            Text("€ 1.50")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section(header: Text("Total")) {
                    let totalStr = "€ " + String(format: "%.2f", viewModel.totalPrice)
                    VStack(alignment: .leading) {
                        Text(totalStr)
                            .font(.title3)
                            .foregroundColor(viewModel.isOverCredit ? .red : .primary)
                        Text("€ \(String(format: "%.2f", viewModel.availableCredit)) on your card")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        if viewModel.isOverCredit {
                            Text("You don't have enough credit.")
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                }

                Section {
                    Button(action: {
                        showingSummary = true
                    }) {
                        Text("Purchase")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(viewModel.isOverCredit)
                }
            }
            .navigationTitle("Choose your drink")
            .sheet(isPresented: $showingSummary) {
                OrderSummaryView(viewModel: viewModel)
            }
        }
    }
}
