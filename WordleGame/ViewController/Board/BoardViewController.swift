//
//  BoardViewController.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import UIKit

class BoardViewController: UIViewController {
        
    public weak var dataSource: BoardViewControllerDelegate? = nil
    
    private let keyboardLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 4
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: keyboardLayout)
        collectionView.register(GuessCell.self, forCellWithReuseIdentifier: GuessCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let logoView: UIImageView = {
        let logo = UIImage(named: "wordle.logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        addSubviews()
        
        addConstraints()
    }
    
    private final func addSubviews() {
        
        view.addSubview(logoView)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private final func addConstraints() {
        NSLayoutConstraint.activate([
            
            logoView.topAnchor.constraint(equalTo: view.topAnchor,  constant: 10),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 150),
            logoView.heightAnchor.constraint(equalToConstant: 70),
            
            collectionView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public final func reloadData() {
        collectionView.reloadData()
    }
}
