//
//  BoardViewController+UICollectionViewDelegate.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation
import UIKit

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = dataSource?.currentGuesses ?? []
        return guesses[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Calculate cell size (as a divider always select first section count)
        let margin: CGFloat = 20
        let guesses = dataSource?.currentGuesses ?? []
        let widthHeight = (collectionView.frame.size.width - margin) / CGFloat(guesses[0].count)
        return CGSize(width: widthHeight, height: widthHeight)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let guessCell = collectionView.dequeueReusableCell(withReuseIdentifier: GuessCell.id, for: indexPath) as? GuessCell else {
            fatalError("Cannot dequeue reusable cell with \(GuessCell.id)!")
        }
        guessCell.backgroundColor = dataSource?.boxColor(at: indexPath)
        let guesses = dataSource?.currentGuesses ?? []
        let guess = guesses[indexPath.section][indexPath.row]
        guessCell.configure(withLetter: guess)
        return guessCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
