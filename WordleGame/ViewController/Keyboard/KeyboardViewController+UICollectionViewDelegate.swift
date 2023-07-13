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
        
        var padding: CGFloat = .zero
        let margin: CGFloat = 20
        let widthHeight = (collectionView.frame.size.width - margin) / 12
        let itemCount = CGFloat(collectionView.numberOfItems(inSection: section))
        padding = (collectionView.frame.size.width - (widthHeight * itemCount) - (2 * itemCount)) / 2
        return UIEdgeInsets(top: 2, left: padding, bottom: 2, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Calculate cell size (as a divider always select first section count)
        let margin: CGFloat = 20
        let widthHeight = (collectionView.frame.size.width - margin) / CGFloat(keys[0].count)
        return CGSize(width: widthHeight, height: widthHeight * 1.4)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let keyCell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.id, for: indexPath) as? KeyCell else {
            fatalError("Cannot dequeue reusable cell with \(KeyCell.id)!")
        }
        let letter = keys[indexPath.section][indexPath.row]
        keyCell.configure(withLetter: letter)
        return keyCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tappedKeyLetter = keys[indexPath.section][indexPath.row]
        delegate?.keyboardViewController(self, didTapKey: tappedKeyLetter)
    }
    
}
