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
    
    lazy var game = Concentration(numberOfCardPaires: (cardButtons.count + 1) / 2)
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumer = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumer)
            updateViewFromModel()
        }
        
    }
    
    func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🐷", "🐸", "🐵", "🦁"]
    
    var emojiMap = [Int: String]()
    
    func getEmoji(for card: Card) -> String
    {
        if emojiMap[card.UID] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiMap[card.UID] = emojiChoices.remove(at: randomIndex)
        }
        return emojiMap[card.UID] ?? "?"
    }
}

