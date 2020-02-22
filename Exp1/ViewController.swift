//
//  ViewController.swift
//  Exp1
//
//  Created by 李海 on 2020/2/22.
//  Copyright © 2020 李海. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount: Int = 0 {
        // call after setter
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🐶", "🐱", "🐭", "🐰", "🦊"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
//        flipCountLabel.text = "Flips: \(flipCount)"
//        flipCard(withEmoji: "🐶", on: sender)
        if let cardNumer = cardButtons.firstIndex(of: sender) {
            print(cardNumer)
            flipCard(withEmoji: emojiChoices[cardNumer], on: sender)
        }
        
    }
    
//    @IBAction func touchCard2(_ sender: UIButton) {
//        flipCount += 1
//        flipCountLabel.text = "Flips: \(flipCount)"
//        flipCard(withEmoji: "🐱", on: sender)
//    }

    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

