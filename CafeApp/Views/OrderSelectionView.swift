//
//  ChooseDrink.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//
import SwiftUI

struct OrderSelectionView: View {
    
    @StateObject var viewModel = OrderViewModel()
    @State private var showingSummary = false
    
    var body: some View{
        NavigationView{
            Form{
                Section(header: Text("Drink")){
                    //Radio
                    Picker("Drink", selection: $viewModel.selectedDrink){
                        ForEach(DrinkType.allCases, id: \.self) { drink in
                            HStack {
                                Text(drink.rawValue)
                                Spacer()
                                Text("$ \(String(format: "%.2f", priceForDrink(type: drink, size: viewModel.selectedSize)))").foregroundColor(.secondary)
                            }
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                Section(header: Text("Size")){
                    Picker("Size", selection: $viewModel.selectedSize) {
                        ForEach(DrinkSize.allCases, id: \.self){ size in
                            Text(size.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Extras")){
                    Toggle(isOn: $viewModel.addSugar){
                        HStack {
                            Text("Sugar")
                            Spacer()
                            Text("Free")
                                .foregroundColor(.secondary)
                        }
                    }
                    .disabled(!viewModel.canAddSugar)
                    
                    Toggle(isOn: $viewModel.addWhippedCream){
                        HStack {
                            Text("Whipped Cream")
                            Spacer()
                            Text("$ 1.50")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Total")) {
                    let totalStr = "$ " + String(format: "%.2f", viewModel.totalPrice)
                    VStack(alignment: .leading) {
                        Text(totalStr)
                            .font(.title3)
                            .foregroundColor(viewModel.isOverCredit ? .red : .primary)
                        Text("$ \(String(format: "%.2f", viewModel.availableCredit)) on your card")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        if viewModel.isOverCredit {
                            Text("You don't have enough credit.")
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section{
                    Button(action: {
                        showingSummary = true
                    }){
                        Text("Purchase")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(viewModel.isOverCredit)
                }
            }
            .navigationTitle("Choose Your Drink")
            .sheet(isPresented: $showingSummary){
                OrderSummaryView(viewModel: viewModel)
            }
        }
    }
}

