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
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // one card face up <- check if match
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
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
        }
    }
    
    func resetGame() {
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = false
            cards[cardIndex].isFaceUp = false
        }
    }
}
