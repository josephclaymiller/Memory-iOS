//
//  Memory.swift
//  Memory
//
//  Created by Joseph Miller on 3/6/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import Foundation

//TODO: Game Score
// +2 points for each match
// -1 point for each previously seen card in a mismatch

class Memory {
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    var seenCardIndicies = [Int]()
    var boardCleared: Bool {
        get {
            for card in cards {
                if !card.isMatched { return false }
            }
            return true
        }
    }
    
    func setUpCards(numberOfPairsOfCards: Int) {
        cards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
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
            // selecting second card, check if match
            if let matchIndex = indexOfFaceUpCard {
                // can't select card already selected
                if matchIndex == index { return false }
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    // remove 1 point for each card seen before
                    if seenCardIndicies.contains(matchIndex) {
                        score -= 1
                    }
                    if seenCardIndicies.contains(index) {
                        score -= 1
                    }
                }
                // Ensure score stays positive
                if score < 0 {
                    score = 0
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
                seenCardIndicies.append(matchIndex)
                seenCardIndicies.append(index)
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
            // card is already matched, can not select
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
        score = 0
        shuffleCards()
    }
}
