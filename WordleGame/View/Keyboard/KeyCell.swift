//
//  KeyCell.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import UIKit

class KeyCell: UICollectionViewCell {
    
    static let id = "KeyboardCellIdentifier"
    public var letter: Character? = nil
    
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initCommon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initCommon()
    }
    
    private final func initCommon() {
        
        backgroundColor = Utilities.shared.darkGray
        
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        letter = nil
        label.text = nil
    }
    
    public func configure(withLetter letter: Character, isEnterKey: Bool = false, isBackspaceKey: Bool = false) {
        if isEnterKey {
            label.text = "Enter"
        } else if isBackspaceKey {
            label.text = "Delete"
        } else {
            label.text = String(letter).uppercased()
            self.letter = letter
        }
    }
    
    // Animations
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // Shrink contentView size to animate on touchEnd
        self.contentView.transform = .init(scaleX: 0.85, y: 0.85)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1, animations: {
            self.contentView.transform = .identity
        })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1, animations: {
            self.contentView.transform = .identity
        })
    }
}

