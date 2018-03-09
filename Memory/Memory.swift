//
//  Memory.swift
//  Memory
//
//  Created by Joseph Miller on 3/6/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import Foundation

class Memory {
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    var flipCount = 0
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    // shuffle the cards
    func shuffleCards() {
        var shuffledCards = [Card]()
        for _ in 0..<(cards.count) {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        cards = shuffledCards
    }
    
    func chooseCard(at index: Int) -> Bool {
        if !cards[index].isMatched {
            // one card face up <- check if match
            if let matchIndex = indexOfFaceUpCard {
                // can't select card already selected
                if matchIndex == index { return false }
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
            } else {
                // either no cards or 2 cards
                // flip down all cards
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                // turn chosen card back face up
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
        } else {
            return false
        }
        flipCount += 1
        return true
    }
    
    func resetGame() {
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = false
            cards[cardIndex].isFaceUp = false
        }
        indexOfFaceUpCard = nil
        flipCount = 0
        shuffleCards()
    }
}
