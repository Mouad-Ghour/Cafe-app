//
//  OrderSummary.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//

import SwiftUI
import MessageUI

struct OrderSummaryView: View {
    @ObservedObject var viewModel: OrderViewModel
    @State private var showMailView = false
    @State private var showMailAlert = false
    
    var body: some View{
        VStack(spacing: 20){
            Text("Your order")
                .font(.largeTitle)
            
            Text(viewModel.summaryText)
                .font(.title3)
            
            Text("Total: $\(String(format: "%.2f", viewModel.totalPrice))")
                .font(.headline)
            
            Button("Order now for $\(String(format: "%.2f", viewModel.totalPrice))"){
                if MFMailComposeViewController.canSendMail() {
                    showMailView = true
                }else{
                    showMailView = false
                }
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(8)
            
        }
        .padding()
        .sheet(isPresented: $showMailView) {
            MailView(subject: viewModel.summaryText,
                     messageBody: emailBody(),
                     recipients: ["coffee-m2sime@univ-rouen.fr"])
        }
        .alert(isPresented: $showMailView){
            Alert(title: Text("Mail not set up"),
                  message: Text("Please configure a mail account in your device."),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    private func emailBody() -> String {
        var body = "Your order details:\n"
        body += "Drink: \(viewModel.selectedDrink.rawValue) (\(viewModel.selectedSize.rawValue)) - $\(String(format: "%.2f", priceForDrink(type: viewModel.selectedDrink, size: viewModel.selectedSize)))\n"
        
        if viewModel.addSugar && viewModel.canAddSugar {
            body += "Extras : Sugar (Free)\n"
        }
        
        if viewModel.addWhippedCream {
            body += "Extras : Whipped Cream ($1.50)\n"
        }
        
        body += "\n Total: $\(String(format: "%.2f", viewModel.totalPrice))"
        
        return body
    }
}

