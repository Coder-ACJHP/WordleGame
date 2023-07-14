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
    
    let answers = [
        "Abuse",    "Alive",    "Array",    "Begin",
        "Actor",    "Allow",    "Aside",    "Begun",
        "Admit",    "Along",    "Audio",    "Below",
        "Adopt",    "Alter",    "Audit",    "Bench",
        "After",    "Anger",    "Award",    "Birth",
        "Agree",    "Apart",    "Baker",    "Blind",
        "Bound",    "Calif",    "Civil",    "Crash",
        "Brief",    "Chart",    "Clock",    "Curve",
        "Broke",   "Check",    "Coast",   "Dance",
        "Built",    "Child",    "Court",    "Death",
        "Debut",    "Entry",    "Forth",    "Group",
        "Doing",    "Event",    "Found",    "Guess",
        "Draft",    "Exist",    "Fraud",    "Happy",
        "Drama",    "Extra",    "Fresh",    "Harry",
        "Drawn",    "Faith",    "Front",    "Heart",
        "Dream",    "False",    "Fruit",    "Heavy",
        "Dress",    "Fault",    "Fully",    "Hence",
        "Drill",    "Fibre",    "Funny",    "Night",
        "Drink",    "Field",    "Giant",    "Horse",
        "Eager",    "Final",    "Going",    "Ideal",
        "Legal",    "Music",    "Mouth",    "Ought",
        "Level",    "Match",    "Movie",    "Paint",
        "Light",    "Mayor",    "Needs",    "Paper",
        "Peace",    "Power",    "Radio",    "Round",
        "Panel",    "Press",    "Raise",    "Route",
        "Pilot",    "Prior",    "Ready",    "Scope",
        "Place",    "Proof",    "Right",    "Sense",
        "Plant",    "Queen",    "Quick",    "Shall",
        "Point",    "Quiet",    "Roman",    "Share",
        "Sheet",    "Spare",    "Style",    "Times",
        "Sixty",    "Start",    "Texas",    "Treat",
        "Small",    "Still",    "There",    "Truck",
        "South",    "Study",    "Throw",    "Until",
        "Usual",    "Train",    "Wheel",    "Wrote",
        "Valid",    "World",    "Where",    "Yield",
        "Value",    "Worry",    "Which",    "Young",
        "Video",    "Worse",    "While",    "Youth",
        "Virus",    "Worst",    "White",    "Worth",
        "Visit",    "Would",    "Vital",    "Voice",
        "zaddy",    "zafus",    "zambo",    "zappy"
    ]
    var answer = ""
    var needsToPressEnter = false
    var lastCursorSection: Int = -1
    var isFirstPressForBackspace = true

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
}

