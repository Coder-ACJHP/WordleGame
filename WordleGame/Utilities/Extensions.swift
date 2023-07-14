//
//  Extensions.swift
//  WordleGame
//
//  Created by Coder ACJHP on 14.07.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func shake() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.values = [0, 10, -10, 0]
        shakeAnimation.duration = 0.25
        shakeAnimation.autoreverses = true
        shakeAnimation.repeatCount = .infinity

        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"shaking")
    }

    func stopShaking() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "shaking")
    }
}
