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
    
    private let messageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 110, height: 40))
        label.backgroundColor = .white
        label.textColor = Utilities.shared.dimGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        view.addSubview(messageLabel)
        messageLabel.isHidden = true
        messageLabel.alpha = .zero
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: collectionView.topAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: messageLabel.frame.width),
            messageLabel.heightAnchor.constraint(equalToConstant: messageLabel.frame.height)
        ])
    }
    
    public final func reloadData() {
        collectionView.reloadData()
    }
    
    public final func reload(section: Int) {
        if section <= collectionView.numberOfSections {
            collectionView.reloadSections([section])            
        }
    }
    
    public final func reload(indexPathes: [IndexPath]) {
        collectionView.reloadItems(at: indexPathes)
    }
    
    public final func getFilledIndexPathes() -> [IndexPath] {
        var resultList = [IndexPath]()
        if !collectionView.visibleCells.isEmpty {
            // Filter filled and visible cells
            let filledCells = collectionView.visibleCells.compactMap { cell in
                if let filledCell = cell as? GuessCell, filledCell.letter != nil { return filledCell }
                return nil
            }
            // If collection if empty return
            if filledCells.isEmpty { return [] }
            
            resultList = filledCells.compactMap { collectionView.indexPath(for: $0) }
        }
        return resultList
    }
    
    public final func shake(section: Int) {
        var cells = [GuessCell]()
        for index in 0 ... 4 {
            let path = IndexPath(row: index, section: section)
            if let cell = collectionView.cellForItem(at: path) as? GuessCell {
                cells.append(cell)
            }
        }
        cells.forEach({ $0.shake() })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            cells.forEach({ $0.stopShaking() })
        }
    }
    
    public final func show(message: String, forSeconds duration: CGFloat = .zero) {
        messageLabel.text = message
        messageLabel.isHidden.toggle()
        UIView.animate(withDuration: 0.5) {
            self.messageLabel.alpha = 1.0
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.5) {
                    self.messageLabel.alpha = .zero
                } completion: { _ in
                    self.messageLabel.isHidden.toggle()
                }
            }
        }
    }
}
