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

    var body: some View {
        VStack(spacing: 20) {
            Text("Your order")
                .font(.largeTitle)

            Text(viewModel.summaryText)
                .font(.title3)

            Text("Total: €\(String(format: "%.2f", viewModel.totalPrice))")
                .font(.headline)

            Button("Order now for €\(String(format: "%.2f", viewModel.totalPrice))") {
                if MFMailComposeViewController.canSendMail() {
                    showMailView = true
                } else {
                    showMailAlert = true
                }
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()

            Image(systemName: "cup.and.saucer.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.brown)
        }
        .padding()
        .sheet(isPresented: $showMailView) {
            MailView(subject: viewModel.summaryText,
                     messageBody: emailBody(),
                     recipients: ["coffee-m2sime@univ-rouen.fr"])
        }
        .alert(isPresented: $showMailAlert) {
            Alert(title: Text("Mail not set up"),
                  message: Text("Please configure a mail account in your device."),
                  dismissButton: .default(Text("OK")))
        }
    }

    private func emailBody() -> String {
        guard let drink = viewModel.currentDrink else { return "" }
        let basePrice = drink.prices[viewModel.selectedSize] ?? 0.0
        var body = "Your order details:\n"
        body += "Drink: \(drink.type.rawValue) (\(viewModel.selectedSize.rawValue)) - €\(String(format: "%.2f", basePrice))\n"
        if viewModel.addSugar && viewModel.canAddSugar {
            body += "Extras: Sugar (Free)\n"
        }
        if viewModel.addWhippedCream {
            body += "Extras: Whipped cream (€1.50)\n"
        }

        body += "\nTotal: €\(String(format: "%.2f", viewModel.totalPrice))"
        return body
    }
}

