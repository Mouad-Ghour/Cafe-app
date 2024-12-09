//
//  EmailService.swift
//  CafeApp
//
//  Created by Ghourdou Mouad on 02/12/2024.
//

import UIKit
import MessageUI

class EmailService: NSObject, MFMailComposeViewControllerDelegate {
    
    static let shared = EmailService()
    
    private override init(){}
    
    func sendOrderEmail(
        drinkType: String,
        size: String,
        extras: [String],
        totalPrice: Double,
        from viewController: UIViewController
    ){
        guard MFMailComposeViewController.canSendMail() else {
            showMailError(from: viewController)
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["coffee-m2sime@univ-rouen.fr"])
        
        let extrasDescription = extras.isEmpty ? "No extras" : extras.joined(separator: ", ")
        mailComposer.setSubject("\(size) \(drinkType) with \(extrasDescription)")

        let body = """
        Order Summary:
        - Drink: \(size) \(drinkType)
        - Extras: \(extrasDescription)
        - Total Price: $\(String(format: ".2f", totalPrice))
        """
        mailComposer.setMessageBody(body, isHTML: false)

        viewController.present(mailComposer, animated: true, completion: nil)
    }
    
    private func showMailError(from viewController: UIViewController){
        let alert = UIAlertController(
            title: "Error",
            message: "Unable to send mail. Please ensure email is set up on your device.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func mailComposeController(
        _ controller : MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ){
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
