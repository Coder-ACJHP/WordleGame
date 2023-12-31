//
//  KeyboardViewController.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    let letters = ["qwertyuıopğü", "asdfghjklşi", "zxcvbnmöç", "12"]
    internal var keys: [[Character]] = []
    internal let enterKey: Character = "1"
    internal let backspaceKey: Character = "2"
    internal let specialKeysWidth: CGFloat = 95
    
    public weak var delegate: KeyboardViewControllerDelegate? = nil
    
    private let keyboardLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1
        return flowLayout
    }()
    
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: keyboardLayout)
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        addSubviews()
        
        addConstraints()
        
        prepareKeys()
    }

    private final func addSubviews() {
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private final func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
