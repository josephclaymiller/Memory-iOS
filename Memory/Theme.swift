//
//  Theme.swift
//  Memory
//
//  Created by Joseph Miller on 3/9/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import Foundation

enum Theme {
    case faces
    case animals
    case plants
    case food
    
    private static let max = 4
    
    static func randomTheme() -> Theme {
        let rand = Int(arc4random_uniform(UInt32(max)))
        switch rand {
        case 0:
            return Theme.animals
        case 1:
            return Theme.plants
        case 2:
            return Theme.food
        default:
            return Theme.faces
        }
    }
}
