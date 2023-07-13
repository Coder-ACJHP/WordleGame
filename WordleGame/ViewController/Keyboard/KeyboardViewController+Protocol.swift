//
//  KeyboardViewController+Protocol.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation

protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboardViewController(_ viewController: KeyboardViewController, didTapKey letter: Character)
}