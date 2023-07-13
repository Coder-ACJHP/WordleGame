//
//  RootViewController+Protocols.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation
import UIKit

extension RootViewController: KeyboardViewControllerDelegate {
    
    func keyboardViewController(_ viewController: KeyboardViewController, didTapKey letter: Character) {
        
        var stop = false
        
        for i in 0 ..< guesses.count {
            for j in 0 ..< guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop { break }
        }

        board.reloadData()
    }
}

extension RootViewController: BoardViewControllerDelegate {
    
    var currentGuesses: [[Character?]] {
        return self.guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap { $0 }.count
        guard count == 5 else { return Utilities.shared.darkGray }
        
        let indexedAnswer = Array(answer.lowercased())
        
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return Utilities.shared.darkGray
        }
        
        if indexedAnswer[indexPath.row] == letter {
            return .green
        }
        
        return .orange
    }
}
