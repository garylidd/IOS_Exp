//
//  File.swift
//  Exp1
//
//  Created by 李海 on 2020/3/9.
//  Copyright © 2020 李海. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var isFaceUp = false
    var isMatched = false
    private var UID: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(UID)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.UID == rhs.UID
    }
    
    static private var UIDGenerator = -1
    static private func getUID() -> Int {
        UIDGenerator += 1
        return UIDGenerator
    }
    
    init()
    {
        self.UID = Card.getUID()
    }
}

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int)
    {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): cards indices don't contain this index")
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfFaceUpCard = index
            }
        }
    }
    
    init(numberOfCardPaires: Int){
        assert(numberOfCardPaires > 0, "Concentration.init(numberOfCardPairs:\(numberOfCardPaires)):number of card pairs should be more than zero")
        for _ in 0..<numberOfCardPaires{
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
