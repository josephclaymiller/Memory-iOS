//
//  Game.swift
//  Memory
//
//  Created by Joseph Miller on 3/24/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import Foundation

class Game {
    var game: Memory
    var level = 0 // start at level 0
    var totalScore = 0

    init() {
        game = Memory()
    }
    
    func setUpCards(numberOfPairsOfCards: Int) {
        game.setUpCards(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    func nextLevel(pairsOfCards: Int) {
        game.setUpCards(numberOfPairsOfCards: pairsOfCards)
    }
    
    func resetLevel() {
        // if cards cleared, increase level
        if game.boardCleared {
            level += 1
            totalScore += game.score
        }
        game.resetGame()
    }
    
    func resetGame() {
        game.resetGame()
        level = 0
    }

}
