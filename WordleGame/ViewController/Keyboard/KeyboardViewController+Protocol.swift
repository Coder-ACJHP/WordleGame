//
//  KeyboardViewController+Protocol.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import Foundation
import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboardViewController(_ viewController: KeyboardViewController, didTapKey letter: Character)
    func keyboardViewControllerDidTapEnterKey(_ viewController: KeyboardViewController)
    func keyboardViewControllerDidTapDeleteKey(_ viewController: KeyboardViewController)
}
