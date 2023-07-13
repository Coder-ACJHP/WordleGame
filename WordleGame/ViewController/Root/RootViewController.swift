//
//  ViewController.swift
//  WordleGame
//
//  Created by Coder ACJHP on 13.07.2023.
//

import UIKit

class RootViewController: UIViewController {
    
    let board = BoardViewController()
    let keyboard = KeyboardViewController()
    
    var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6
    )
    
    let answers = ["After", "later", "block", "there", "ultra"]
    var answer = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = Utilities.shared.dimGray
        
        addChilderens()
        
        pickAnAnswer()
    }


    private final func addChilderens() {
        addChild(board)
        board.dataSource = self
        board.didMove(toParent: self)
        board.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(board.view)
        
        addChild(keyboard)
        keyboard.delegate = self
        keyboard.didMove(toParent: self)
        keyboard.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboard.view)
        
        addConstraints()
    }
    
    private final func addConstraints() {
        
        NSLayoutConstraint.activate([
            board.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            board.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            board.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            board.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.65),
            
            keyboard.view.topAnchor.constraint(equalTo: board.view.bottomAnchor, constant: 30),
            keyboard.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            keyboard.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            keyboard.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private final func pickAnAnswer() {
        answer = answers.randomElement() ?? "words"
    }
}

