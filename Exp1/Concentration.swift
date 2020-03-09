//
//  File.swift
//  Exp1
//
//  Created by 李海 on 2020/3/9.
//  Copyright © 2020 李海. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var UID: Int
    
    static var UIDGenerator = -1
    static func getUID() -> Int {
        UIDGenerator += 1
        return UIDGenerator
    }
    
    init()
    {
        self.UID = Card.getUID()
    }
}

class Concentration
{
    var cards = [Card]()
    
    var indexOfFaceUpCard: Int?
    
    func chooseCard(at index: Int)
    {
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex].UID == cards[index].UID {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
        }
    }
    
    init(numberOfCardPaires: Int){
        for _ in 0..<numberOfCardPaires{
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}
