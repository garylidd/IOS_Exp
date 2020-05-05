//
//  ViewController.swift
//  Exp1
//
//  Created by 李海 on 2020/2/22.
//  Copyright © 2020 李海. All rights reserved.
//

import UIKit


extension CGFloat {
    var arc4random: CGFloat {
        return self * (CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max))
    }
}

class ViewController: UIViewController {
    
    var flipCount: Int = 0 {
        // call after setter
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var collsionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(behavior)
        return behavior
    } ()
    
    lazy var dynamicItemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.elasticity = 0.1
        behavior.allowsRotation = false
        self.animator.addBehavior(behavior)
        return behavior
    } ()

    
    lazy var game = Concentration(numberOfCardPaires: (cardButtons.count + 1) / 2)
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumer = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumer)
            updateViewFromModel()
        }
    }
    
    override func viewDidLoad() {
        for button in cardButtons {
            collsionBehavior.addItem(button)
            dynamicItemBehavior.addItem(button)
            let pushBehavior = UIPushBehavior(items: [button], mode: .instantaneous)
            pushBehavior.angle =  (2 * CGFloat.pi).arc4random
            pushBehavior.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4random
            animator.addBehavior(pushBehavior)
        }
    }
    
    func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isStateChange {
                UIView.transition(with: button,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                              animations: {
                                    if card.isFaceUp
                                    {
                                        button.setTitle(self.getEmoji(for: card), for: UIControl.State.normal)
                                        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                    } else {
                                        button.setTitle("", for: UIControl.State.normal)
                                        button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                                    }
                                
                },
                              completion: { _ in
                                if card.isMatched {
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.7,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            button.alpha = 0
                                    },
                                        completion: nil)
                                }
                                self.game.cards[index].isStateChange = false})
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

