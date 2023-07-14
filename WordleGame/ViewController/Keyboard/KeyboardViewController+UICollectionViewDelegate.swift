//
//  KeyboardViewController+UICollectionViewDelegate.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation
import UIKit

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin: CGFloat = 20
        // Check current key to change enter & backspace buttons size
        var widthHeight = (collectionView.frame.size.width - margin) / 12
        if section == 3 { widthHeight = specialKeysWidth }
        let itemCount = CGFloat(collectionView.numberOfItems(inSection: section))
        let padding = (collectionView.frame.size.width - (widthHeight * itemCount) - (2 * itemCount)) / 2
        return UIEdgeInsets(top: 2, left: padding, bottom: 2, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Calculate cell size (as a divider always select first section count)
        let margin: CGFloat = 20
        let widthHeight = (collectionView.frame.size.width - margin) / CGFloat(keys[0].count)
        
        // Check current key to change enter & backspace buttons size
        let currentKey = keys[indexPath.section][indexPath.row]
        if currentKey == enterKey || currentKey == backspaceKey {
            return CGSize(width: specialKeysWidth, height: widthHeight * 1.4)
        }
        return CGSize(width: widthHeight, height: widthHeight * 1.4)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let keyCell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.id, for: indexPath) as? KeyCell else {
            fatalError("Cannot dequeue reusable cell with \(KeyCell.id)!")
        }
        let letter = keys[indexPath.section][indexPath.row]
        
        // Check current key to change enter & backspace buttons size
        let currentKey = keys[indexPath.section][indexPath.row]
        if currentKey == enterKey {
            keyCell.configure(withLetter: letter, isEnterKey: true)
        } else if currentKey == backspaceKey {
            keyCell.configure(withLetter: letter, isBackspaceKey: true)
        } else {
            keyCell.configure(withLetter: letter)
        }
        
        return keyCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentKey = keys[indexPath.section][indexPath.row]
        if currentKey == enterKey {
            delegate?.keyboardViewControllerDidTapEnterKey(self)
        } else if currentKey == backspaceKey {
            delegate?.keyboardViewControllerDidTapDeleteKey(self)
        } else {
            delegate?.keyboardViewController(self, didTapKey: currentKey)
        }
        
    }
    
}
