//
//  ViewController.swift
//  HangmanLetterGame
//
//  Created by Nick Sagan on 31.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var deathProgress: UIProgressView!
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "G", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var clue = "Your lovely programming language:"
    var answer = "SWIFT"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.font = .systemFont(ofSize: 32)
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        clueLabel = UILabel()
        clueLabel.font = .systemFont(ofSize: 32)
        clueLabel.text = "Clue"
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.textAlignment = .center
        clueLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(clueLabel)
        
        answerLabel = UILabel()
        answerLabel.font = .systemFont(ofSize: 32)
        answerLabel.text = "?????????"
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textAlignment = .center
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
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
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            clueLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            answerLabel.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 20),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deathProgress.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            deathProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deathProgress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            buttonsView.topAnchor.constraint(equalTo: deathProgress.bottomAnchor, constant: 60),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalToConstant: 500),
            buttonsView.heightAnchor.constraint(equalToConstant: 400)
            
        
        ])
        
        for row in 0...3 {
            for column in 0...4 {
                let button = UIButton(type: .system)
                button.setTitle("A", for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 56)
                button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * 100, y: row * 100, width: 100, height: 100)
                button.frame = frame
                buttonsView.addSubview(button)
                letterButtons.append(button)
            }
        }
    }
    
    func loadLevel() {
        letterButtons.shuffle()
        deathProgress.progress = 0.0
        
        var tempAnswer = [String]()
        
        // You can add as many level files as you want
        if let levelFileUrl = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if var levelContents = try? String(contentsOf: levelFileUrl) {
                levelContents = levelContents.trimmingCharacters(in: .newlines)
                let levelText = levelContents.components(separatedBy: ":")
                answer = levelText[1]
                clue = levelText[0]
                clueLabel.text = clue
            }
        }
        
        answerLabel.text = ""
        for letter in answer {
            answerLabel.text! += "?"
            tempAnswer.append(String(letter))
        }
        
        var tempAlphabet = alphabet
        
        // This needed to exclude letter duplicates from alphabet
        for letter in tempAnswer {
            for alphLetter in tempAlphabet {
                if alphLetter == letter {
                    tempAlphabet = tempAlphabet.filter { $0 != alphLetter }
                }
            }
        }

        for button in letterButtons {
            button.isHidden = false
            var letter: String
            if tempAnswer.count > 0 {
                letter = tempAnswer.removeFirst()
            } else if tempAlphabet.count > 0 {
                letter = tempAlphabet.removeFirst()
            } else {
                letter = "?"
            }
            button.setTitle(letter, for: .normal)
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        let chosenLetter = sender.titleLabel!.text!
        if answer.contains(chosenLetter) {
            score += 1
            var itIsFirstCase = true
            for letter in answer {
                if String(letter) == chosenLetter && itIsFirstCase {
                    let x = answer.firstIndex(of: letter)!
                    answerLabel.text = answerLabel.text?.replacingCharacters(in: x...x, with: chosenLetter)
                    itIsFirstCase = false
                    sender.isHidden = true
                }
            }
            if answer == answerLabel.text {
                answerLabel.textColor = .systemGreen
                answerLabel.text! += " - YOU WIN!"
                
                let ac = UIAlertController(title: "You win!", message: "Ready for next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: levelUp))
                present(ac, animated: true, completion: nil)
            }
            
        } else {
            score -= 1
            deathProgress.progress += 0.15
            if deathProgress.progress >= 1.0 {
                answerLabel.textColor = .systemRed
                answerLabel.text! += " - YOU LOSE!"
                let ac = UIAlertController(title: "You lose!", message: "Ready to play again?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: playAgain))
                present(ac, animated: true, completion: nil)
            }
        }
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        loadLevel()
    }
    func playAgain(action: UIAlertAction) {
        level = 1
        loadLevel()
    }
}
