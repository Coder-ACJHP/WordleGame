//
//  KeyboardViewController+Helpers.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation
import UIKit

extension KeyboardViewController {
    
    internal func prepareKeys() {
        for row in letters {
            let characters = Array(row)
            keys.append(characters)
        }
    }
    
    public final func reloadData() {
        collectionView.reloadData()
    }
}
