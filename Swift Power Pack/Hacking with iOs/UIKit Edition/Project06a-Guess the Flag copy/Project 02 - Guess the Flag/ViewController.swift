//
//  ViewController.swift
//  Project 02 - Guess the Flag
//
//  Created by Arnaud Miguet on 29.11.20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var coutries = [String]()
    var score = 0
    var numberOfQuestionsAsked = 0
    
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate coutries array
        coutries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Buttons styling
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
//            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        askQuestion()
    }
    
    /// Populates the 3 buttons with random flag images
    func askQuestion(action: UIAlertAction! = nil) {
        coutries.shuffle()
        button1.setImage(UIImage(named: coutries[0]), for: .normal)
        button2.setImage(UIImage(named: coutries[1]), for: .normal)
        button3.setImage(UIImage(named: coutries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(coutries[correctAnswer].uppercased()) - Score : \(score)"
        numberOfQuestionsAsked += 1
    }
    
    
    
    @objc
    func showScore() {
        let ac = UIAlertController(title: "Your score is \(score)", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(coutries[sender.tag].uppercased())"
            score -= 1
        }
        if numberOfQuestionsAsked < 10 {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your final score is \(score) / 10", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { alert in
                self.numberOfQuestionsAsked = 0
                self.score = 0
                self.askQuestion()
            }))
            present(ac, animated: true)
        }
    }
}

