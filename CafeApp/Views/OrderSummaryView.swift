//
//  OrderSummary.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//

import SwiftUI
import MessageUI

struct OrderSummary: View {
    
    @ObservedObject var viewModel: DrinkViewModel
    
    var body: some View{
        VStack{
            Text("Order Summary")
                .font(.title)
            
            Text("\(viewModel.selectedSize.rawValue) \(viewModel.selectedDrink.rawValue)")
            if viewModel.extras.isEmpty{
                Text("No extras")
            } else {
                ForEach(viewModel.extras, id:\.self) { extra in
                        Text(extra)
                }
            }
            
            Text("Total: $\(viewModel.total, specifier: "%.2f")")
            
            Button(action: sendEmail){
                Text("Order now for $\(viewModel.total, specifier: "%.2f")")
            }
            .padding()
        }
    }
    
    private func sendEmail(){
        let drinkType = viewModel.selectedDrink.rawValue
        let size = viewModel.selectedSize.rawValue
        let extras = viewModel.extras
        let totalPrice = viewModel.total

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController{
                EmailService.shared.sendOrderEmail(
                    drinkType: drinkType,
                    size: size,
                    extras: extras,
                    totalPrice: totalPrice,
                    from: rootViewController
                )
            }
    }
}
