//
//  ViewController.swift
//  Challenge04
//
//  Created by Arnaud Miguet on 02.12.20.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Outlets
    
    @IBOutlet var usedLettersLabel: UILabel!
    @IBOutlet var letterToTryTextField: UITextField!
    @IBOutlet var wordToGuessLabel: UILabel!
    @IBOutlet var remainingLivesLabel: UILabel!
    
    // MARK: - Properties
    
    var listOfWords = ["Dog", "Escalator", "Football", "Architecture", "Program", "Hangman"]
    var remainingLives = 7 {
        didSet {
            remainingLivesLabel.text = "Remaining lives: \(remainingLives)"
        }
    }
    var chosenWord: String?
    var usedLetters = Set<Character>() {
        didSet {
            usedLettersLabel.text = usedLetters.reduce("") {$0 + String($1)}
            updateMainLabel()
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    func startGame() {
        chosenWord = listOfWords.randomElement()
        usedLetters = Set<Character>()
        remainingLives = 7
    }
    
    func updateMainLabel() {
        var textToShow = ""
        if let chosenWord = chosenWord?.uppercased() {
            for letter in chosenWord {
                textToShow += usedLetters.contains(letter) ? String(letter.uppercased()) : "?"
            }
        }
        wordToGuessLabel.text = textToShow
    }
    
    func showError(title: String, message: String?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }


    // MARK: - UI Intents
    @IBAction func tryLetter(_ sender: UIButton) {
        guard let userInput = letterToTryTextField.text else { showError(title: "Error reading text", message: nil); return }
        guard userInput.count == 1 else { showError(title: "Please enter one letter", message: nil); return}
        guard !usedLetters.contains(Character(userInput)) else { showError(title: "You already tried that letter", message: "Please enter another one"); return }
        
        usedLetters.insert(Character(userInput.uppercased()))
        letterToTryTextField.text = ""
        letterToTryTextField.resignFirstResponder()
        
        if let chosenWord = chosenWord?.uppercased() {
            if !chosenWord.contains(userInput.uppercased()) {
                remainingLives -= 1
                if remainingLives == 0 {
                    let ac = UIAlertController(title: "You lost!", message: "The word was \(chosenWord)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Restart", style: .default) { [weak self] action in
                        self?.startGame()
                    })
                    present(ac, animated: true)
                }
            }
            
            var isOver = true
            for letter in chosenWord {
                if !usedLetters.contains(letter) {
                    isOver = false
                }
            }
            if isOver {
                let ac = UIAlertController(title: "You won!", message: "The word was indeed \(chosenWord)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default) { [weak self] action in
                    self?.startGame()
                })
                present(ac, animated: true)
            }
        }
    }
}

