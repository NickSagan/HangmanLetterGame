//
//  ViewController.swift
//  HangmanLetterGame
//
//  Created by Nick Sagan on 31.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var deathProgress: UIProgressView!
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "G", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.font = .systemFont(ofSize: 32)
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        clueLabel = UILabel()
        clueLabel.font = .systemFont(ofSize: 32)
        clueLabel.text = "A big tree with apples:"
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.textAlignment = .center
        view.addSubview(clueLabel)
        
        answerLabel = UILabel()
        answerLabel.font = .systemFont(ofSize: 32)
        answerLabel.text = "?????????"
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textAlignment = .center
        view.addSubview(answerLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 2
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        deathProgress = UIProgressView()
        deathProgress.translatesAutoresizingMaskIntoConstraints = false
        deathProgress.progress = 0.5
        view.addSubview(deathProgress)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            
            clueLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            answerLabel.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 20),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deathProgress.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            deathProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deathProgress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            //buttonsView.topAnchor.constraint(equalTo: deathProgress.bottomAnchor, constant: 60),
            buttonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        
        ])
    }

}

