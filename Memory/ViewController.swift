//
//  ViewController.swift
//  Memory
//
//  Created by Joseph Miller on 3/4/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cardBackColor: UIColor = UIColor.black
    var cardFrontColor: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    lazy var game = Memory(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameBoard: UIView!
    var emojiChoices = [String]() // chosen emoji set to use for a game
    var emoji = [Int:String]() // dictionary to track emojis used in game

    override func viewDidLoad() {
        super.viewDidLoad()
        setRandomTheme()
    }
 
    // Choose a random theme and update the view
    func setRandomTheme() {
        let newTheme = Theme.randomTheme()
        setTheme(newTheme)
        updateViewFromModel()
    }
    
    func setTheme(_ newTheme: Theme) {
        switch newTheme {
        case .animals:
            emojiChoices = animalEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case .animalHeads:
            emojiChoices = animalHeads
            gameBoard.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case .catHeads:
            emojiChoices = catHeads
            gameBoard.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case .plants:
            emojiChoices = plantEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case .food:
            emojiChoices = foodEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        default:
            emojiChoices = faceEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
    }
    
    @IBAction func pressNewGameButton(_ sender: UIButton) {
        game.resetGame()
        emoji = [Int:String]() // empty emoji array
        setRandomTheme()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            print("card number = \(cardNumber)")
            if game.chooseCard(at: cardNumber){
                print("Flipped card")
            } else {
                print("Can not select that card")
            }
            updateViewFromModel()
        } else {
            print("chosen card not in card array")
        }
    }
    
    func updateViewFromModel() {
        // Update score
        scoreLabel.text = "Score: \(game.score)"
        // Update flip count
        flipCountLabel.text = "Flips: \(game.flipCount)"
        // Look at all the cards and see if there are matches
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = cardFrontColor
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : cardBackColor
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        print(emoji[card.identifier] ?? "?")
        return emoji[card.identifier] ?? "?"
    }
    
}

