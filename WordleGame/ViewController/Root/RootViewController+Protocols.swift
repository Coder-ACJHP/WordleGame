//
//  RootViewController+Protocols.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation
import UIKit

extension RootViewController: KeyboardViewControllerDelegate {
    
    // Other Keys
    func keyboardViewController(_ viewController: KeyboardViewController, didTapKey letter: Character) {
        
        // Mark as true to allow finding section at deletion of character
        isFirstPressForBackspace = true
        
        if needsToPressEnter { return }
        
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
        
        // Check if current column is filled prevent writing until enter press
        needsToPressEnter = currentColumnIsFilled()
    }

    
    // Delete Key
    func keyboardViewControllerDidTapDeleteKey(_ viewController: KeyboardViewController) {
        
        var stop = false

        // Find in which section was typing user when last letter wrote
        findLastLetterSectionIndex()
        
        // If there no section like (-1) do not do anything
        guard lastCursorSection != -1 else { return }
                        
        // Allow to remove only current section letters
        for i in (0 ..< guesses.count).reversed() {
            for j in (0 ..< guesses[i].count).reversed() {
                if i == lastCursorSection {
                    if guesses[i][j] != nil {
                        guesses[i][j] = nil
                        stop = true
                        break
                    }
                }
            }
            if stop { break }
        }

        board.reloadData()
    }
    
    // Enter Key
    func keyboardViewControllerDidTapEnterKey(_ viewController: KeyboardViewController) {
        needsToPressEnter = false
        
        var displayingResult: AlertItem? = nil
        switch gameIsOver() {
        case .win:
            board.reloadData()
            displayingResult = AlertContext.winMessage
        case .lose:
            board.reloadData()
            displayingResult = AlertContext.loseMessage
        case .continues:
            if guessContainsAnyLetterOfAnswer() {
                board.reloadData()
            } else {
                board.shake(section: findLastSection())
                board.show(message: "Not in list!", forSeconds: 1)
            }
        }
        
        guard let displayingResult else { return }
        
        let alertPopover = UIAlertController(
            title: displayingResult.title,
            message: displayingResult.message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: displayingResult.buttonTitle, style: .default) { _ in
            self.resetGame()
        }
        alertPopover.addAction(action)
        self.present(alertPopover, animated: true)
    }
}

extension RootViewController: BoardViewControllerDelegate {
    
    var currentGuesses: [[Character?]] {
        return self.guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        
        findLastLetterSectionIndex()
        
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap { $0 }.count
        
        guard count == 5 else { return Utilities.shared.darkGray }
        
        if needsToPressEnter && lastCursorSection == rowIndex {
            return Utilities.shared.darkGray
        }
        
        let indexedAnswer = Array(answer.lowercased())
        
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return Utilities.shared.darkGray
        }
        
        // Correct letter in correct position
        if indexedAnswer[indexPath.row] == letter {
            return .green
        }
        // Correct letter at wrong position
        return .orange
    }
}
