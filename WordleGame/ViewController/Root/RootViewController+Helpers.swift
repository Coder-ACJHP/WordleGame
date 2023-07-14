//
//  RootViewController+Helpers.swift
//  WordleGame
//
//  Created by Coder ACJHP on 14.07.2023.
//

import Foundation

extension RootViewController {
    
    internal final func pickAnAnswer() {
        answer = answers.randomElement() ?? "words"
    }
    
    public final func findLastSection() -> Int {
        var section = -1
        for index in (0 ..< guesses.count).reversed() {
            let guessList = guesses[index]
            if !guessList.compactMap({ $0 }).isEmpty {
                section = index
                break
            }
        }
        return section
    }
    
    internal func findLastLetterSectionIndex() {
        // Get last typed item section in 2d array then disable running this peace of code until flag marked as true
        if isFirstPressForBackspace {
            lastCursorSection = findLastSection()
            isFirstPressForBackspace = false
        }
    }
    
    internal final func currentColumnIsFilled() -> Bool {
        // Filter guesses and find subarray that not all elements nil
        let mappedGuesses = guesses.map({ $0.compactMap({ $0 }) }).filter({ !$0.isEmpty })
        guard let guessList = mappedGuesses.last else { return false }
        if guessList.count == 5 {
            return true
        }
        return false
    }
    
    internal final func gameIsOver() -> PosibileGameResult {
        
        if guesses[5][4] != nil {
            return .lose
        }
        
        lastCursorSection = findLastSection()
        for index in 0 ... lastCursorSection {
            let section = guesses[index]
            let sectionWord = String(section.compactMap({$0 }))
            if sectionWord.lowercased() == answer.lowercased() {
                return .win
            }
        }
        return .continues
    }
    
    internal func resetGame() {
        pickAnAnswer()
        guesses = Array(
            repeating: Array(repeating: nil, count: 5),
            count: 6
        )
        board.reloadData()
    }
    
    internal final func guessContainsAnyLetterOfAnswer() -> Bool {
        lastCursorSection = findLastSection()
        let section = guesses[lastCursorSection]
        let sectionChars = section.compactMap({ $0 })
        let answerChars = Array(answer)
        return Set(answerChars).intersection(Set(sectionChars)).count > 1
    }
}
