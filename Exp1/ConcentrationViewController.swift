//
//  ViewController.swift
//  Exp1
//
//  Created by 李海 on 2020/2/22.
//  Copyright © 2020 李海. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private(set) var flipCount: Int = 0 {
        // call after setter
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    lazy private var game = Concentration(numberOfCardPaires: numberOfCardPairs)
    
    var numberOfCardPairs: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumer = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumer)
            updateViewFromModel()
        }
        
    }
    
    private func updateViewFromModel()
    {
        if cardButtons != nil {
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
    }
    
    var theme: [String]? {
        didSet {
            emojiChoices = theme ?? [""]
            emojiMap = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🐷", "🐸", "🐵", "🦁"]
    private var emojiMap = [Card: String]()
    
    private func getEmoji(for card: Card) -> String
    {
        if emojiMap[card] == nil, emojiChoices.count > 0 {
            emojiMap[card] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
        }
        return emojiMap[card] ?? "?"
    }
}

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0;
        }
    }
}
