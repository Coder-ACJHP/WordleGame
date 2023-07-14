//
//  Alerts.swift
//  WordleGame
//
//  Created by Coder ACJHP on 14.07.2023.
//

import Foundation

struct AlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var buttonTitle: String
}

struct AlertContext {
    
    static let winMessage = AlertItem(
        title: "You Win 🎉",
        message: "You're so smart. You beat your own AI.",
        buttonTitle: "Hell Yeah"
    )
    
    static let loseMessage = AlertItem(
        title: "Game Over",
        message: "Would you like to try again?",
        buttonTitle: "Try Again"
    )
}
