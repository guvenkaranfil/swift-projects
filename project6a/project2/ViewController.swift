//
//  ViewController.swift
//  project2
//
//  Created by Güven Karanfil on 16.12.2020.
//  Copyright © 2020 Güven Karanfil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
            
        askQuestion()
    }
    
    
    func tryAgain(action: UIAlertAction! = nil) {
        score = 0
        correctAnswer = 0
        questionCount = 0
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        if (questionCount == 10){
            let ac = UIAlertController(title: "Final score is \(score)", message: "Start again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start!", style: .default, handler: tryAgain))
            
            return present(ac, animated: true)
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Score: \(score) \(countries[correctAnswer].uppercased())"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag])"
            score -= 1
        }
        
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        questionCount += 1
    }
    
}

