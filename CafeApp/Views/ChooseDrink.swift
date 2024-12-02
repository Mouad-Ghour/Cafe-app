//
//  ChooseDrink.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//
import SwiftUI

struct ChooseDrink: View {
    @StateObject private var viewModel = DrinkViewModel()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Choose Your Drink")){
                    Picker("Drink", selection: $viewModel.selectedDrink){
                        ForEach(DrinkType.allCases, id: \.self){ drink in
                            Text(drink.rawValue).tag(drink)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Size", selection: $viewModel.selectedSize){
                        ForEach(DrinkType.allCases, id: \.self) { drink in
                            Text(drink.rawValue).tag(drink)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Extras")){
                    Toggle("Sugar", isOn: Binding(
                        get: {viewModel.extras.contains("Sugar")},
                        set: {if $0 {viewModel.extras.append("Sugar") } else { viewModel.extras.removeAll { $0 == "Sugar" } } }
                    ))
                    .disabled(viewModel.selectedDrink == .chocolate)
                
                    Toggle("Whipped Cream ($1.50)", isOn: Binding(
                        get: { viewModel.extras.contains("Whipped Cream") },
                        set: { if $0 { viewModel.extras.append("Whiped Cream") } else { viewModel.extras.removeAll {$0 == "Whipped Cream" } } }
                    ))
                }
                
                Section {
                    Text("Total: $\(viewModel.total, specifier: "%.2f")")
                        .foregroundColor(viewModel.canPurchase ? .black : .red)
                    
                    NavigationLink("Purchase", destination: OrderSummary(viewModel: viewModel))
                        .disabled(!viewModel.canPurchase)
                }
            }
            .onChange(of: viewModel.selectedDrink) { _ in viewModel.calculateTotal()}
            .onChange(of: viewModel.selectedSize) { _ in viewModel.calculateTotal()}
            .onChange(of: viewModel.extras) { _ in viewModel.calculateTotal()}
            .navigationTitle("Choose Drink")
        }
    }
}
