//
//  Card.swift
//  Memory
//
//  Created by Joseph Miller on 3/6/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func geteUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.geteUniqueIdentifier()
    }
}
